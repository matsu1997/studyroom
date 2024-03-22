import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/main.dart';

class V1Add extends StatefulWidget {
  @override
  _V1AddState createState() => _V1AddState();
}

class _V1AddState extends State<V1Add> {
  String infoText = '';
  String email = '';
  String password = '';
  var uid = "";
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
        title: Text("科目を追加",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: '科目名'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('追加'),
                  onPressed: ()  {
                    Add();
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
    print(uid);
    return id;
  }
  void showProgressDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });}
  Future<void> Add() async {
    showProgressDialog();
    if (email != "") {
      var aa = randomString(20);
      await FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("科目").doc(aa) // ドキュメントID自動生成
          .set({
        "kamoku": email,
        "messageId": aa,
        "uid":uid,
      });
      _controller.clear();
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
  }
  String randomString(int length) {
    const _randomChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;

    final rand = new Random();
    final codeUnits = new List.generate(
      length,
          (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);
      },
    );
    return new String.fromCharCodes(codeUnits);
  }
}
