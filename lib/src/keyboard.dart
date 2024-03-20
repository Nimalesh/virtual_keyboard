import 'package:flutter/material.dart';

class OnScreenKeys extends StatefulWidget {
  const OnScreenKeys(
      {super.key,
      required this.primaryColor,
      required this.accentColor,
      required this.textColor,
      required this.keyColor,
      required this.textFieldBg,
      required this.hintTextColor,
      required this.hintIconColor,
      required this.textFieldBorderColor,
      required this.hintText,
      required this.customButtonText,
      required this.keyAxisCount,
      required this.customButton});

  final Color primaryColor;
  final Color accentColor;
  final Color textColor;
  final Color keyColor;
  final Color textFieldBg;
  final Color hintTextColor;
  final Color hintIconColor;
  final Color textFieldBorderColor;
  final String hintText;
  final String customButtonText;
  final int keyAxisCount;
  final Function customButton; // Custom function for clear button

  @override
  State<OnScreenKeys> createState() => _OnScreenKeysState();
}

class _OnScreenKeysState extends State<OnScreenKeys> {
  TextEditingController textEditingController = TextEditingController();

  void _onKeyPressed(String value) {
    setState(() {
      textEditingController.text += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'On-screen Keyboard',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: textEditingController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: widget.textFieldBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: widget.textFieldBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: widget.primaryColor),
                  ),
                  filled: true,
                  fillColor: widget.textFieldBg,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: widget.hintTextColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: widget.hintIconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        textEditingController.clear();
                      });
                      widget.customButton();
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: widget.keyAxisCount,
              children: List.generate(
                12,
                (index) {
                  List<String> keys = [
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '0',
                    '⌫',
                    widget.customButtonText
                  ];
                  return InkWell(
                    onTap: () {
                      if (index == 10) {
                        // Backspace
                        setState(() {
                          textEditingController.text =
                              textEditingController.text.isNotEmpty
                                  ? textEditingController.text.substring(
                                      0, textEditingController.text.length - 1)
                                  : '';
                        });
                      } else if (index == 11) {
                        setState(() {
                          textEditingController.clear(); // Clear text field
                        });
                        // Call the clearTextField function passed from MyApp
                        widget.customButton();
                      } else {
                        _onKeyPressed(keys[index]);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: widget.keyColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        keys[index],
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
