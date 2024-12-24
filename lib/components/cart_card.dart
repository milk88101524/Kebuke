import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final Cart cart;
  final Function()? onIncrement;
  final Function()? onDecrement;
  final Function()? onTap;
  const CartCard(
      {super.key,
      required this.cart,
      required this.onIncrement,
      required this.onDecrement,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorAccent, width: 3),
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 10,
        color: colorBG,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      "https://raw.githubusercontent.com/milk88101524/kebukeMenu/main/${cart.drinkName}.jpg",
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.drinkName,
                          style: TextStyle(
                            color: colorAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cart.size,
                          style: TextStyle(color: colorAccent),
                        ),
                        Text(
                          cart.sweetness,
                          style: TextStyle(color: colorAccent),
                        ),
                        Text(cart.ice, style: TextStyle(color: colorAccent)),
                        Text(
                          "${cart.whiteBubble == "true" ? "\n+白玉 +\$10" : ""} "
                          "${cart.whiteJelly == "true" ? "\n+水玉 +\$10" : ""} "
                          "${cart.sweetAlmond == "true" ? "\n+甜杏 +\$15" : ""}",
                          style: TextStyle(color: colorAccent),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "NT\$${cart.price} x${cart.count}",
                      style: TextStyle(
                        color: colorAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Material(
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            onTap: onDecrement,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(width: 1, color: Colors.white),
                        Material(
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            onTap: onIncrement,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
