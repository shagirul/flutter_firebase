import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/main.dart';
import 'package:firebase_tut/utils.dart';
import 'package:firebase_tut/widget/Button_widget.dart';
import 'package:firebase_tut/widget/Email_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ))),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(flex: 50, child: Container()),
            EmailTextFieldWidget(
                textcontroller: emailController,
                hint: "Email",
                borderradius: 12),
            Expanded(flex: 5, child: Container()),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            InkWell(
              onTap: () {
                verifyEmail();
              },
              child: ButtonWidget(
                  backgroundcolor: Colors.black,
                  text: "Reset Password",
                  textcolor: Colors.white),
            ),
            Expanded(flex: 10, child: Container()),
          ],
        ),
      ),
    );
  }

  Future verifyEmail() async {
    // related to the circular indicator between login transition
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    // ////
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Uttils.showSnackBar("Password reset email sent");
    } on FirebaseAuthException catch (e) {
      Uttils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working !!////help to popup the circular indicator after login
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}
