import 'package:firebase_tut/utils.dart';
import 'package:firebase_tut/widget/Button_widget.dart';
import 'package:firebase_tut/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();
  final decscriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    decscriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ))),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   user.email!,
              //   style: const TextStyle(fontSize: 30),
              // ),
              Expanded(flex: 50, child: Container()),
              TextFieldWidget(
                  hint: "Title",
                  maxline: 1,
                  borderradius: 20,
                  textcontroller: titleController),
              Expanded(flex: 3, child: Container()),
              TextFieldWidget(
                  hint: "Description",
                  maxline: 5,
                  borderradius: 12,
                  textcontroller: decscriptionController),
              Expanded(flex: 6, child: Container()),
              InkWell(
                onTap: () {
                  final task = titleController.text;
                  final description = decscriptionController.text;
                  createToDos(title: task, description: description);

                  setState(() {
                    titleController.text = "";
                    decscriptionController.text = "";
                  });
                },
                child: ButtonWidget(
                    backgroundcolor: Colors.black,
                    text: "Add Task",
                    textcolor: Colors.white),
              ),
              Expanded(flex: 10, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Future createToDos(
      {required String title, required String description}) async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc();
    final json = {'Title': title, 'Description': description};
    await docUser.set(json);
    Navigator.pop(context);
    Uttils.showSnackBar('Task Added Succesfully');
    // navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}
