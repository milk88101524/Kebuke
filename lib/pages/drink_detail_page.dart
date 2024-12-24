import 'dart:async';

import 'package:flu_drinks/bloc/cart_bloc/cart_bloc.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_event.dart';
import 'package:flu_drinks/bloc/cart_bloc/cart_state.dart';
import 'package:flu_drinks/bloc/drink_update_bloc/drink_update_bloc.dart';
import 'package:flu_drinks/bloc/drink_update_bloc/drink_update_event.dart';
import 'package:flu_drinks/bloc/drink_update_bloc/drink_update_state.dart';
import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/components/ice_menu.dart';
import 'package:flu_drinks/components/material_menu.dart';
import 'package:flu_drinks/components/size_menu.dart';
import 'package:flu_drinks/components/sweetness_menu.dart';
import 'package:flu_drinks/models/cart_model.dart';
import 'package:flu_drinks/models/drink_model.dart';
import 'package:flu_drinks/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DrinkDetailPage extends StatelessWidget {
  final Drink drink;
  final String name;
  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DrinkUpdateBloc>(
          create: (context) => DrinkUpdateBloc(drink),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: DrinkDetailPageView(
        drink: drink,
        name: name,
      ),
    );
  }
}

class DrinkDetailPageView extends StatelessWidget {
  final Drink drink;
  final String name;
  const DrinkDetailPageView({
    super.key,
    required this.drink,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    String size = "",
        sweetness = "",
        ice = "",
        whiteBubble = "false",
        whiteJelly = "false",
        sweetAlmond = "false";
    int price = 0, count = 0;

    return Scaffold(
      backgroundColor: colorBG,
      body: BlocListener<CartBloc, CartState>(
        listener: (BuildContext context, state) {
          if (state is CartAddCartFail) {
            showSnack(context, state.message);
          } else if (state is CartAddCartSuccess) {
            showSnack(context, state.message);
            Timer(Duration(milliseconds: 500),
                () => Navigator.pop(context, true));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image.network(drink.img),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          drink.name,
                          style: TextStyle(
                            fontSize: 24,
                            color: colorAccent,
                          ),
                        ),
                        BlocBuilder<DrinkUpdateBloc, DrinkUpdateState>(
                          builder: (context, state) {
                            price = state.price;
                            count = state.count;
                            return Text(
                              "NT\$${state.price}",
                              style: TextStyle(
                                fontSize: 24,
                                color: colorAccent,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      drink.desc,
                      style: TextStyle(
                        fontSize: 20,
                        color: colorAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizeMenu(
                      onSelected: (value) {
                        context.read<DrinkUpdateBloc>().add(UpdateSize(value!));
                        size = value;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SweetnessMenu(onSelected: (value) {
                      context
                          .read<DrinkUpdateBloc>()
                          .add(UpdateSweetness(value!));
                      sweetness = value;
                    }),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IceMenu(onSelected: (value) {
                      context.read<DrinkUpdateBloc>().add(UpdateIce(value!));
                      ice = value;
                    }),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MaterialMenu(
                      onChangedWhiteBubble: (value) {
                        context
                            .read<DrinkUpdateBloc>()
                            .add(UpdateWhiteBubble(value.toString()));
                        whiteBubble = value.toString();
                      },
                      onChangedWhiteJelly: (value) {
                        context
                            .read<DrinkUpdateBloc>()
                            .add(UpdateWhiteJelly(value.toString()));
                        whiteJelly = value.toString();
                      },
                      onChangedSweetAlmond: (value) {
                        context
                            .read<DrinkUpdateBloc>()
                            .add(UpdateSweetAlmond(value.toString()));
                        sweetAlmond = value.toString();
                      },
                    ),
                  )
                ],
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
                  child: BlocBuilder<DrinkUpdateBloc, DrinkUpdateState>(
                      builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${drink.name} ${state.size} "
                            "${state.sweetness} ${state.ice} "
                            "${state.whiteBubble == "true" ? "\n+白玉 +\$10" : ""} "
                            "${state.whiteJelly == "true" ? "\n+水玉 +\$10" : ""} "
                            "${state.sweetAlmond == "true" ? "\n+甜杏 +\$15" : ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "NT\$${state.price}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "數量：${state.count}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<DrinkUpdateBloc>()
                                          .add(Increment(count));
                                      count = state.count;
                                    },
                                    child: Text(
                                      "+",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<DrinkUpdateBloc>()
                                          .add(Decrement(count));
                                      count = state.count;
                                    },
                                    child: Text(
                                      "-",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 80,
                  child: Material(
                    color: colorAccent,
                    child: InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(
                              AddCart(
                                Cart(
                                  Uuid().v4(),
                                  drink.name,
                                  size,
                                  sweetness,
                                  ice,
                                  name,
                                  price.toString(),
                                  count.toString(),
                                  whiteBubble,
                                  whiteJelly,
                                  sweetAlmond,
                                ),
                              ),
                            );
                        // 新增購物車後直接 pop 並通知更新
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
                              "加入購物車",
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
            ),
          ],
        ),
      ),
    );
  }
}
