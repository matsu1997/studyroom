import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/V2GruoCreate.dart';
import 'V2FriendPage.dart';
import 'V2FriendAdd.dart';
import 'V2GrupAdd.dart';
import 'V2GrupMember.dart';
import 'fab_animation.dart';

class V2GrupMemberAdd extends StatefulWidget {
  @override
  V2GrupMemberAdd(this.uid,this.name);
   String uid;
   String name;
  State<V2GrupMemberAdd> createState() => _V2GrupMemberAddState();
}

class _V2GrupMemberAddState extends State<V2GrupMemberAdd> {
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var item1 = [];
  var uid = "";
  var text = "";
  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:Text("招待",style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            child: Text("友達"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.library_books_rounded,
                      ),
                      title: Text(item[index]["name"]),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text("グループに招待しますか？",
                                    textAlign: TextAlign.center,),
                                  actions: <Widget>[
                                    Column(
                                      children: [
                                        Center(
                                          child: ElevatedButton(
                                              child: Text('招待'),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('users').doc(
                                                    item[index]["uid"]) // コレクションID指定
                                                    .collection("グループ招待中").doc(
                                                    widget.uid) // ドキュメントID自動生成
                                                    .set({
                                                  "uid": widget.uid,
                                                  "name": widget.name,
                                                });
                                                Navigator.pop(context, '');
                                              }
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text("キャンセル"),
                                          onPressed: () {
                                            Navigator.pop(context, 'cancel');
                                          },
                                        )
                                      ],)
                                  ],));
                      }),
                );
              },
            ),
          ),
        ]));
  }

  Future<String> inputData() async {
    final user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    if (id != null) {
      _loadData();
    }
    return id;
  }

  void _loadData() {
    item = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("友達")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);});});});
    setState(() {});
  }
}