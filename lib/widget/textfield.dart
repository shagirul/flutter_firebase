import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hint;
  final double borderradius;
  final int? maxline;
  const TextFieldWidget(
      {Key? key,
      required this.textcontroller,
      required this.hint,
      required this.borderradius,
      this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxline,
      controller: textcontroller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black26,
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderradius),
              borderSide: BorderSide(color: Colors.white, width: 0.50)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderradius),
              borderSide: BorderSide(color: Colors.white, width: 0.50))),
    );
  }
}
