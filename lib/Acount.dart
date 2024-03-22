import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/main.dart';

class Acount extends StatefulWidget {
  @override
  _AcountState createState() => _AcountState();
}

class _AcountState extends State<Acount> {

  String infoText = '';
  String email = '';
  String password = '';
  var uid = "";
  var name = "";
  var item = [];
  var _controller = TextEditingController();
  void initState() {
    super.initState();
    inputData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("アカウントを編集",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力
              Text("現在の名前："+ name,),
              FittedBox(
                fit: BoxFit.fitWidth,
                child:Text("友達に表示されるのでわかりやすい名前にしましょう",style: TextStyle(color: Colors.red,),),),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText:"新しい名前"),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('編集'),
                  onPressed: ()  {
                    Add();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:30),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('編集しない'),
                  onPressed: ()  {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData1();
    return id;
  }
  Future<void> Add() async {
    if (email != "") {
      await FirebaseFirestore.instance
          .collection('users').doc(uid)
          .update({
        "name": email,
      });
      _controller.clear();}
    _loadData1();
  }
  void _loadData1() {
    item = [];
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          name = doc["name"];
        });});});
  }
}
