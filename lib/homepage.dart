import 'package:firebase_tut/addtask.dart';
import 'package:firebase_tut/utils.dart';
import 'package:firebase_tut/widget/Button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> docIDs = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentuser = FirebaseAuth.instance.currentUser!.uid;

  deleteTAsk(String item) {
    FirebaseFirestore.instance.collection(currentuser).doc(item).delete();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Your Task List",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: const Icon(
                Icons.power_settings_new_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTask(),
          ));
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.attach_file),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(currentuser).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("something went wrong");
          } else if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.only(
                right: 9,
                left: 9,
                top: 12,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                          child: ListTile(
                            // onLongPress: () {},
                            title: Text(
                                ((documentSnapshot != null)
                                    ? documentSnapshot["Title"]
                                    : ''),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              ((documentSnapshot != null)
                                  ? documentSnapshot["Description"]
                                  : ''),
                              style: const TextStyle(),
                            ),
                          ),
                        )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _onAlertButtonPressed1(context) {
                                  AlertDialog alert = AlertDialog(
                                    title: Container(
                                        padding: EdgeInsets.all(15),
                                        // color: Colors.red,
                                        child: const Center(
                                            child: Text("Warning !!!"))),
                                    content: const Text(
                                        "Do You Really Want To Delete Task"),
                                    actions: [
                                      TextButton(
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteTAsk(documentSnapshot!.id);
                                          Uttils.showSnackBar(
                                              'Task deleted Succesfully');
                                        },
                                      )
                                      //your actions (I.E. a button)
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }

                                _onAlertButtonPressed1(context);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
