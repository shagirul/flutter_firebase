import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/widget/Button_widget.dart';
import 'package:firebase_tut/widget/Email_textfield.dart';
import 'package:firebase_tut/widget/password_textFeild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_tut/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'utils.dart';

import 'main.dart';

class SignupWidget extends StatefulWidget {
  final VoidCallback onClickSignIn;
  const SignupWidget({Key? key, required this.onClickSignIn}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //     image: AssetImage("assets/loginWidget.jpg"), fit: BoxFit.cover)
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
                flex: 50,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "HELLO THERE",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "We Welcome You To Our App Hope You Love It",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )),
            EmailTextFieldWidget(
                textcontroller: emailController,
                hint: "Email",
                borderradius: 12),
            Expanded(flex: 2, child: Container()),
            PasswordTextFieldWidget(
                textcontroller: passwordController,
                hint: "Password",
                borderradius: 12),
            Expanded(flex: 3, child: Container()),
            InkWell(
              onTap: () {
                signUp();
              },
              child: ButtonWidget(
                  backgroundcolor: Colors.black,
                  text: "Sign-Up",
                  textcolor: Colors.white),
            ),
            Expanded(flex: 4, child: Container()),
            RichText(
                text: TextSpan(
                    text: "Already have a account?   ",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickSignIn,
                      text: "Sign-In",
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black))
                ])),
            Expanded(flex: 4, child: Container()),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    ///validation of the input usnig form keys
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    // related to the circular indicator between login transition
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    // ////
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Uttils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working !!////help to popup the circular indicator after login
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}
