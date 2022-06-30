import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tut/authpage.dart';
import 'package:firebase_tut/homepage.dart';
import 'package:firebase_tut/utils.dart';
import 'package:flutter/material.dart';
// Import the generated file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyAOAIiVVTroUhsOZJ4VbLMdBqC3kp0FFy8",
      appId: "1:186008926749:android:91eae410605d81e99ca4f4",
      messagingSenderId: "186008926749",
      projectId: "my-fire-base-project-9fa53",
    ),
  );
  runApp(MyApp());
}

// globalkey assigned for nvigator state
final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  // final messageKey = GlobalKey<ScaffoldMessengerState>();
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: messengerKey,
        // defined for the popup action defined in showDialog method
        navigatorKey: navigatorkey,
        // //////////////
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: Scaffold(
              body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            // initialData: initialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // #############################################################

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: const Text("Something went wrong"),
                );
                // ###########################################################

              } else if (snapshot.hasData) {
                return HomePage();
              } else {
                return AuthPage();
              }
            },
          )),
        ));
  }
}
