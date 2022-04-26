import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitrush/utilities/colors.dart';

class GrayedFormWidget extends StatefulWidget {
  String hint;
  String initialText;
  String inputKey;
  int sequenceIdentifier;
  IconData? icon;
  Function? iconClickListener;
  GrayedFormWidget(
      {Key? key,
      required this.sequenceIdentifier,
      required this.hint,
      required this.initialText,
      required this.inputKey,
      this.icon,
      this.iconClickListener})
      : super(key: key);

  @override
  _GrayedFormWidgetState createState() => _GrayedFormWidgetState();
}

class _GrayedFormWidgetState extends State<GrayedFormWidget> {
  final controller = TextEditingController();
  int sequenceIdentifier = -1;
  String title = "";
  String hint = "";
  String initialText = "";
  String inputKey = "";
  Function? iconClickListener;
  IconData? icon;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    sequenceIdentifier = widget.sequenceIdentifier;
    hint = widget.hint;
    initialText = widget.initialText;
    inputKey = widget.inputKey;
    icon = widget.icon;
    iconClickListener = widget.iconClickListener;
  }

  void click() {
    // FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = hint;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: grayField,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              enabled: false,
              controller: controller,
              cursorColor: Colors.deepOrange,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            child: InkWell(
              splashColor: rushYellow,
              onTap: () {
                iconClickListener!();
              },
              child: Icon(
                icon,
                color: black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
