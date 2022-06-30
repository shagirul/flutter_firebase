import 'package:firebase_tut/forgotpassword.dart';
import 'package:firebase_tut/utils.dart';
import 'package:firebase_tut/widget/Button_widget.dart';
import 'package:firebase_tut/widget/Email_textfield.dart';
import 'package:firebase_tut/widget/password_textFeild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickSignUp;
  const LoginWidget({Key? key, required this.onClickSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
      child: Column(
        children: [
          Expanded(
              flex: 50,
              child: Container(
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
                        "Welocome Back We Missed You So Much",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              )),
          EmailTextFieldWidget(
              textcontroller: emailController, hint: "Email", borderradius: 12),
          Expanded(flex: 2, child: Container()),
          PasswordTextFieldWidget(
              textcontroller: passwordController,
              hint: "Password",
              borderradius: 12),
          Expanded(flex: 3, child: Container()),
          InkWell(
            onTap: () {
              signIn();
            },
            child: ButtonWidget(
                backgroundcolor: Colors.black,
                text: "Sign-In",
                textcolor: Colors.white),
          ),
          Expanded(flex: 4, child: Container()),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForgotPasswordWidget(),
            )),
            child: const Text("Forgot Password ?",
                style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    color: Colors.black)),
          ),
          Expanded(flex: 2, child: Container()),
          RichText(
              text: TextSpan(
                  text: "No Account?   ",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickSignUp,
                    text: "Sign-Up",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black))
              ])),
          Expanded(flex: 4, child: Container()),
        ],
      ),
    );
  }

  Future signIn() async {
    // related to the circular indicator between login transition
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    // ////
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Uttils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working !!////help to popup the circular indicator after login
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}
