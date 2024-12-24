import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    TextEditingController controller = TextEditingController();

    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
        backgroundColor: colorBG,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/kebuke.png"),
                SizedBox(height: 50),
                Text(
                  "今天    你想來杯可不可嗎",
                  style: TextStyle(color: colorAccent, fontSize: 20),
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: colorAccent),
                        focusNode: focusNode,
                        controller: controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        cursorColor: colorAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: FloatingActionButton(
                        backgroundColor: colorAccent,
                        foregroundColor: colorBG,
                        onPressed: () {
                          if (controller.text.isEmpty) {
                            showWarningAlert(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(username: controller.text),
                              ),
                            );
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios),
                      ),
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

void showWarningAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: colorBG,
      title: Text(
        "Warning",
        style: TextStyle(color: colorAccent),
      ),
      content: Text(
        "名字不能為空",
        style: TextStyle(color: colorAccent),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: colorAccent),
          ),
        ),
      ],
    ),
  );
}
