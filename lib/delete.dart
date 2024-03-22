import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(delete());
}

class delete extends StatefulWidget {
  @override
  State<delete> createState() => _deleteState();
}

class _deleteState extends State<delete> {
  String uid = "uid";

  String getuid = "getuid";

  String deleteuser = "wait delete";

  late User me;

  Column CheckAuthInstance() {
    return Column(
      children: [
        RaisedButton(
          child: const Text('アカウントを削除'),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () {
            try {
              FirebaseAuth.instance.currentUser?.uid;
              setState(() {
                getuid = FirebaseAuth.instance.currentUser!.uid;
              });
            } on NoSuchMethodError catch (e) {
              setState(() {
                getuid = "null";
              });
            }
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text("アカウントを削除しますか？"),
                      content: Text("全データが消えます。"),
                      actions: <Widget>[
                        GestureDetector(
                          child: Text('いいえ'),
                          onTap: () {
                            Navigator.pop(context);
                          },),
                        GestureDetector(
                          child: Text('はい'),
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection(
                                "users").doc(getuid)
                                .delete();
                           // setState(() {});
                            try {
                              FirebaseAuth.instance.currentUser;

                              FirebaseAuth.instance.currentUser?.delete();
                              setState(() {
                                deleteuser = "deleted";
                              });
                            } on NoSuchMethodError catch (e) {
                              setState(() {
                                deleteuser = "no exist user";
                              });
                            }
                            Navigator.pop(context);



                          },)],));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("削除",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckAuthInstance(),
          ],
        ),
      ),
    );
  }
}
