import 'package:firebase_tut/signup_Widget.dart';
import 'package:flutter/material.dart';
import 'login_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(
          onClickSignUp: toggle,
        )
      : SignupWidget(onClickSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
