import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/models/cart_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Cart cart;
  const OrderCard({
    super.key,
    required this.cart,
  });

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        cart.username,
                        style: TextStyle(
                          color: colorAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cart.drinkName,
                        style: TextStyle(
                          color: colorAccent,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cart.size,
                        style: TextStyle(
                          color: colorAccent,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cart.sweetness,
                        style: TextStyle(
                          color: colorAccent,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cart.ice,
                        style: TextStyle(
                          color: colorAccent,
                          fontSize: 16,
                        ),
                      ),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
