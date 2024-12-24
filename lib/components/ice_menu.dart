import 'package:flu_drinks/components/app_color.dart';
import 'package:flutter/material.dart';

class IceMenu extends StatefulWidget {
  final String? initIce;
  final Function(String?)? onSelected;
  const IceMenu({
    super.key,
    required this.onSelected,
    this.initIce,
  });

  @override
  State<IceMenu> createState() => _IceMenuState();
}

class _IceMenuState extends State<IceMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onSelected?.call(widget.initIce ?? "正常冰");
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
                    initialSelection: widget.initIce ?? "正常冰",
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none, // 移除底線
                      enabledBorder: InputBorder.none, // 非焦點狀態時移除底線
                      focusedBorder: InputBorder.none, // 焦點狀態時移除底線
                      outlineBorder: BorderSide.none, // 確保邊框無效
                      //["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
                    ),
                    width: MediaQuery.of(context).size.width,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "正常冰", label: "正常冰"),
                      DropdownMenuEntry(value: "少冰", label: "少冰"),
                      DropdownMenuEntry(value: "微冰", label: "微冰"),
                      DropdownMenuEntry(value: "去冰", label: "去冰"),
                      DropdownMenuEntry(value: "完全去冰", label: "完全去冰"),
                      DropdownMenuEntry(value: "常溫", label: "常溫"),
                      DropdownMenuEntry(value: "溫", label: "溫"),
                      DropdownMenuEntry(value: "熱", label: "熱"),
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
                "冰塊",
                style: TextStyle(color: colorAccent, fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }
}
