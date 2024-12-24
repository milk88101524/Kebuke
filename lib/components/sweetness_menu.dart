import 'package:flu_drinks/components/app_color.dart';
import 'package:flutter/material.dart';

class SweetnessMenu extends StatefulWidget {
  final String? initSweetness;
  final Function(String?)? onSelected;
  const SweetnessMenu({
    super.key,
    required this.onSelected,
    this.initSweetness,
  });

  @override
  State<SweetnessMenu> createState() => _SweetnessMenuState();
}

class _SweetnessMenuState extends State<SweetnessMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onSelected?.call(widget.initSweetness ?? "正常糖");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorAccent, width: 3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: colorAccent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: DropdownMenu(
                    trailingIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    textStyle: TextStyle(color: Colors.white),
                    initialSelection: widget.initSweetness ?? "正常糖",
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none, // 移除底線
                      enabledBorder: InputBorder.none, // 非焦點狀態時移除底線
                      focusedBorder: InputBorder.none, // 焦點狀態時移除底線
                      outlineBorder: BorderSide.none, // 確保邊框無效
                    ),
                    width: MediaQuery.of(context).size.width,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "正常糖", label: "正常糖"),
                      DropdownMenuEntry(value: "少糖", label: "少糖"),
                      DropdownMenuEntry(value: "半糖", label: "半糖"),
                      DropdownMenuEntry(value: "微糖", label: "微糖"),
                      DropdownMenuEntry(value: "二分糖", label: "二分糖"),
                      DropdownMenuEntry(value: "一分糖", label: "一分糖"),
                      DropdownMenuEntry(value: "無糖", label: "無糖"),
                    ],
                    onSelected: widget.onSelected,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            color: colorBG,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "甜度",
                style: TextStyle(color: colorAccent, fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }
}
