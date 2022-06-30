import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hint;
  final double borderradius;
  final int? maxline;
  const PasswordTextFieldWidget(
      {Key? key,
      required this.textcontroller,
      required this.hint,
      required this.borderradius,
      this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: true,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        controller: textcontroller,
        // obscureText: true,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderradius),
                borderSide: BorderSide(color: Colors.white, width: 0.50)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderradius),
                borderSide: BorderSide(color: Colors.white, width: 0.50)))
        //////
        ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          value != null && value.length < 6 ? "Enter min 6 character " : null;
        });
  }
}
