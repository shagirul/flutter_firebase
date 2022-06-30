import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailTextFieldWidget extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hint;
  final double borderradius;
  final int? maxline;
  const EmailTextFieldWidget({
    Key? key,
    required this.textcontroller,
    required this.hint,
    required this.borderradius,
    this.maxline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        controller: textcontroller,
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
        validator: (email) {
          email != null && !EmailValidator.validate(email)
              ? "enter a valid email"
              : null;
        });
  }
}
