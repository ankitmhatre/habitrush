// import 'package:flutter/material.dart';

// class CustomTextInput extends StatefulWidget {
//   const CustomTextInput({Key? key}) : super(key: key);

//   @override
//   _CustomTextInputState createState() => _CustomTextInputState();
// }

// class _CustomTextInputState extends State<CustomTextInput>
//     with SingleTickerProviderStateMixin {
//   var textController = TextEditingController();
//   String title = "";
//   String hint = "";
//   String initialText = " ";
//   String inputKey = "";

//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//     textController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//       color: const Color.fromARGB(255, 232, 232, 232),
//       child: TextFormField(
//         controller: textController,
//         cursorColor: Colors.deepOrange,
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           labelText: widget.hint,
//           labelStyle: TextStyle(color: Colors.deepOrange),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidget extends StatefulWidget {
  String hint;
  String initialText;
  String inputKey;

  TextInputWidget(
      {Key? key,
      required this.hint,
      required this.initialText,
      required this.inputKey})
      : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String title = "";
  String hint = "";
  String initialText = "";
  String inputKey = "";
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    hint = widget.hint;
    initialText = widget.initialText;
    inputKey = widget.inputKey;
  }

  void click() {
    // FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: const Color.fromARGB(255, 232, 232, 232),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.deepOrange,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
