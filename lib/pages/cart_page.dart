import 'dart:async';
import 'package:flu_drinks/bloc/cart_bloc/cart_bloc.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_event.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_state.dart';
import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/components/cart_card.dart';
import 'package:flu_drinks/models/api_manager.dart';
import 'package:flu_drinks/models/cart_model.dart';
import 'package:flu_drinks/models/drink_model.dart';
import 'package:flu_drinks/pages/edit_cart_page.dart';
import 'package:flu_drinks/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: CartPageView(),
    );
  }
}

class CartPageView extends StatelessWidget {
  const CartPageView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(LoadCart());

    return Scaffold(
      backgroundColor: colorBG,
      appBar: AppBar(
        backgroundColor: colorBG,
        foregroundColor: colorAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (BuildContext context, state) {
          if (state is CartEditCartSuccess) {
            showSnack(context, state.message);
          } else if (state is CartDeleteCartSuccess) {
            showSnack(context, state.message);
          } else if (state is CartEditCartFail) {
            showSnack(context, state.message);
          } else if (state is CartDeleteCartFail) {
            showSnack(context, state.message);
          } else if (state is CartAddOrderSuccess) {
            showSnack(context, state.message);
          } else if (state is CartAddOrderFail) {
            showSnack(context, state.message);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CartLoadSuccess) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return CartCard(
                          cart: state.carts[index],
                          onIncrement: () {
                            int newCount =
                                int.parse(state.carts[index].count) + 1;
                            context.read<CartBloc>().add(EditCartCount(
                                state.carts[index], newCount.toString()));
                          },
                          onDecrement: () {
                            int newCount =
                                int.parse(state.carts[index].count) - 1;
                            if (newCount > 0) {
                              context.read<CartBloc>().add(EditCartCount(
                                  state.carts[index], newCount.toString()));
                            } else {
                              context
                                  .read<CartBloc>()
                                  .add(DeleteCart(state.carts[index]));
                            }
                          },
                          onTap: () async {
                            Drink drink =
                                await findDrink(state.carts[index].drinkName);
                            if (context.mounted) {
                              bool? needRefresh = await showModalBottomSheet(
                                isScrollControlled: true,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height - 80,
                                ),
                                context: context,
                                builder: (context) {
                                  return EditCartPage(
                                    cart: state.carts[index],
                                    drink: drink,
                                  );
                                },
                              );

                              if (needRefresh != null &&
                                  context.mounted &&
                                  needRefresh) {
                                context.read<CartBloc>().add(LoadCart());
                              }
                            }
                          },
                        );
                      },
                      itemCount: state.carts.length,
                    );
                  } else if (state is CartLoadFail) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 10,
                        blurStyle: BlurStyle.inner,
                      ),
                      BoxShadow(
                        color: colorBgOpacity,
                        blurRadius: 10,
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        int count = 0;
                        int price = 0;
                        if (state is CartLoadSuccess) {
                          for (Cart cart in state.carts) {
                            price = price +
                                (int.parse(cart.count) * int.parse(cart.price));
                            count = count + int.parse(cart.count);
                          }
                        } else if (state is CartLoading) {
                          count = 0;
                          price = 0;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "杯數\n$count",
                              style: TextStyle(
                                color: colorAccent,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "總計\n$price",
                              style: TextStyle(
                                color: colorAccent,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Material(
                    color: colorAccent,
                    child: InkWell(
                      onTap: () {
                        final carts = (BlocProvider.of<CartBloc>(context).state
                                as CartLoadSuccess)
                            .carts;
                        context.read<CartBloc>().add(AddOrder(carts));
                        for (var cart in carts) {
                          context.read<CartBloc>().add(DeleteCart(cart));
                        }

                        Timer(Duration(seconds: 2),
                            () => Navigator.pop(context, true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "結帳",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
