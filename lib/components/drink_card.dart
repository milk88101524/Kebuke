import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/models/drink_model.dart';
import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  final Drink drink;
  final Function()? onTap;
  const DrinkCard({
    super.key,
    required this.drink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(),
      color: colorBG,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(drink.img),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "—",
                    style: TextStyle(color: colorAccent),
                  ),
                  SizedBox(width: 10),
                  Text(
                    drink.name,
                    style: TextStyle(
                      color: colorAccent,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "—",
                    style: TextStyle(color: colorAccent),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
