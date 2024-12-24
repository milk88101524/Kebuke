import 'package:flu_drinks/components/app_color.dart';
import 'package:flutter/material.dart';

class MaterialMenu extends StatefulWidget {
  final String? initWhiteBubble, initWhiteJelly, initSweetAlmond;
  final Function(bool)? onChangedWhiteBubble;
  final Function(bool)? onChangedWhiteJelly;
  final Function(bool)? onChangedSweetAlmond;

  const MaterialMenu({
    super.key,
    this.onChangedWhiteBubble,
    this.onChangedWhiteJelly,
    this.onChangedSweetAlmond,
    this.initWhiteBubble,
    this.initWhiteJelly,
    this.initSweetAlmond,
  });

  @override
  State<MaterialMenu> createState() => _MaterialMenuState();
}

class _MaterialMenuState extends State<MaterialMenu> {
  late bool selectWhiteBubble;
  late bool selectWhiteJelly;
  late bool selectSweetAlmond;

  @override
  void initState() {
    super.initState();
    // 初始化成員變數
    selectWhiteBubble =
        widget.initWhiteBubble != null && widget.initWhiteBubble == "true";
    selectWhiteJelly =
        widget.initWhiteJelly != null && widget.initWhiteJelly == "true";
    selectSweetAlmond =
        widget.initSweetAlmond != null && widget.initSweetAlmond == "true";
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
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    _buildMenuItem(
                      label: "+白玉",
                      isSelected: selectWhiteBubble,
                      onTap: () {
                        setState(() {
                          selectWhiteBubble = !selectWhiteBubble;
                        });
                        widget.onChangedWhiteBubble?.call(selectWhiteBubble);
                      },
                    ),
                    SizedBox(height: 8),
                    _buildMenuItem(
                      label: "+水玉",
                      isSelected: selectWhiteJelly,
                      onTap: () {
                        setState(() {
                          selectWhiteJelly = !selectWhiteJelly;
                        });
                        widget.onChangedWhiteJelly?.call(selectWhiteJelly);
                      },
                    ),
                    SizedBox(height: 8),
                    _buildMenuItem(
                      label: "+甜杏",
                      isSelected: selectSweetAlmond,
                      onTap: () {
                        setState(() {
                          selectSweetAlmond = !selectSweetAlmond;
                        });
                        widget.onChangedSweetAlmond?.call(selectSweetAlmond);
                      },
                    ),
                    SizedBox(height: 8),
                  ],
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
                "加選料",
                style: TextStyle(color: colorAccent, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Checkbox(
            checkColor: colorBG,
            activeColor: Colors.white,
            value: isSelected,
            onChanged: (value) {
              onTap(); // 當 Checkbox 被點擊時，觸發 InkWell 的邏輯
            },
          ),
        ],
      ),
    );
  }
}
