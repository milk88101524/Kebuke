import 'package:flu_drinks/bloc/cart_bloc/cart_bloc.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_event.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_state.dart';
import 'package:flu_drinks/bloc/drinks_bloc/drinks_bloc.dart';
import 'package:flu_drinks/bloc/drinks_bloc/drinks_event.dart';
import 'package:flu_drinks/bloc/drinks_bloc/drinks_state.dart';
import 'package:flu_drinks/bloc/order_bloc/order_bloc.dart';
import 'package:flu_drinks/bloc/order_bloc/order_event.dart';
import 'package:flu_drinks/bloc/order_bloc/order_state.dart';
import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/components/custom_button.dart';
import 'package:flu_drinks/components/drink_card.dart';
import 'package:flu_drinks/pages/cart_page.dart';
import 'package:flu_drinks/pages/drink_detail_page.dart';
import 'package:flu_drinks/pages/order_page.dart';
import 'package:flu_drinks/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DrinksBloc>(
          create: (context) => DrinksBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(),
        ),
      ],
      child: HomePageView(
        username: username,
      ),
    );
  }
}

class HomePageView extends StatelessWidget {
  final String username;
  const HomePageView({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DrinksBloc>(context).add(LoadDrink());
    BlocProvider.of<CartBloc>(context).add(GetCartCount());
    BlocProvider.of<OrderBloc>(context).add(GetOrderCount());

    return Scaffold(
      backgroundColor: colorBG,
      body: BlocListener<OrderBloc, OrderState>(
        listener: (BuildContext context, state) {
          if (state is OrderLoadFail) {
            showSnack(context, state.message);
          }
        },
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  backgroundColor: colorAccent,
                  onPressed: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios_new),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello\n$username",
                      style: TextStyle(
                        fontSize: 20,
                        color: colorAccent,
                      ),
                    ),
                    BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                      int badge = 0;
                      if (state is OrderCountLoadSuccess) {
                        badge = state.count;
                      } else {
                        badge = 0;
                      }
                      return CustomButton(
                        icon: Icons.menu,
                        btnText: "團購明細",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(),
                          ),
                        ),
                        badge: badge,
                      );
                    }),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<DrinksBloc, DrinksState>(
                      builder: (context, state) {
                    if (state is DrinkLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DrinkLoadSuccess) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return DrinkCard(
                              drink: state.drinks[index],
                              onTap: () async {
                                bool? needRefresh = await showModalBottomSheet(
                                  isScrollControlled: true,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height - 80,
                                  ),
                                  context: context,
                                  builder: (context) => DrinkDetailPage(
                                    drink: state.drinks[index],
                                    name: username,
                                  ),
                                );

                                if (needRefresh != null &&
                                    context.mounted &&
                                    needRefresh) {
                                  context.read<CartBloc>().add(GetCartCount());
                                }
                              });
                        },
                        itemCount: state.drinks.length,
                      );
                    } else if (state is DrinkLoadFail) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colorAccent,
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  }),
                  // child:
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            int count = 0;
            if (state is CartCountLoadSuccess) {
              count = state.count;
            } else {
              count = 0;
            }
            return Badge(
              isLabelVisible: (count > 0) ? true : false,
              label: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  count.toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              backgroundColor: colorAccent,
              offset: Offset(0, -10),
              child: FloatingActionButton(
                heroTag: "fab",
                backgroundColor: colorAccent,
                onPressed: () async {
                  bool? needRefresh = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );

                  if (needRefresh != null && context.mounted && needRefresh) {
                    context.read<CartBloc>().add(GetCartCount());
                    context.read<OrderBloc>().add(GetOrderCount());
                  }
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: colorBG,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
