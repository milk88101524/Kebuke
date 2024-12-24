import 'package:flu_drinks/components/app_color.dart';
import 'package:flutter/material.dart';

class SizeMenu extends StatefulWidget {
  final String? initSize;
  final Function(String?)? onSelected;
  const SizeMenu({
    super.key,
    required this.onSelected,
    this.initSize,
  });

  @override
  State<SizeMenu> createState() => _SizeMenuState();
}

class _SizeMenuState extends State<SizeMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onSelected?.call(widget.initSize ?? "M");
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
                    initialSelection: widget.initSize ?? "M",
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none, // 移除底線
                      enabledBorder: InputBorder.none, // 非焦點狀態時移除底線
                      focusedBorder: InputBorder.none, // 焦點狀態時移除底線
                      outlineBorder: BorderSide.none, // 確保邊框無效
                    ),
                    width: MediaQuery.of(context).size.width,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "M", label: "M"),
                      DropdownMenuEntry(value: "L", label: "L"),
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
                "尺寸",
                style: TextStyle(color: colorAccent, fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }
}
