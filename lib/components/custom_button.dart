import 'package:flu_drinks/components/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String btnText;
  final int badge;
  const CustomButton({
    super.key,
    required this.icon,
    required this.btnText,
    required this.onTap,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Badge(
        isLabelVisible: (badge > 0) ? true : false,
        label: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            badge.toString(),
            style: TextStyle(fontSize: 15),
          ),
        ),
        backgroundColor: colorAccent,
        offset: Offset(-5, -10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: colorAccent,
                ),
                SizedBox(width: 5),
                Text(
                  btnText,
                  style: TextStyle(
                      color: colorAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
