import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/main.dart';
import 'package:url_launcher/url_launcher.dart';
class V2GrupCreate extends StatefulWidget {
  @override
  _V2GrupCreateState createState() => _V2GrupCreateState();
}

class _V2GrupCreateState extends State<V2GrupCreate> {
  // メッセージ表示用
  String infoText = '';
  String email = '';
  String name = '';
  String password = '';
  var uid = "";
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
        title: Text("グループ作成",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        leadingWidth: 80,
        actions: <Widget>[
        ],),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // メールアドレス入力
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'グループの名前'),
              onChanged: (String value) {
                setState(() {
                  name = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.all(8),
              // メッセージ表示
              child: Text(infoText),
            ),
            Container(
              width: double.infinity,
              // ユーザー登録ボタン
              child: ElevatedButton(
                  child: Text('登録'),
                  onPressed: () async {add();}
              ),
            ),
          ],
        ),
      ));
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
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData();
    return id;
  }
Future<void> add() async {
 // showProgressDialog();
  var rum = randomString(20);
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) async {
    await FirebaseFirestore.instance
        .collection('グループ').doc(rum)// コレクションID指定
        .set({
      "uid":rum,
      "name":name,
      "createdAt": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection('グループ').doc(rum).collection("メンバー").doc(uid)// コレクションID指定
        .set({
      "uid":uid,
      "name":item[0]["name"],
      "createdAt": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection('users').doc(uid).collection("グループ").doc(rum)// コレクションID指定
        .set({
      "uid":rum,
      "name":name,
      "createdAt": Timestamp.now(),
    });
  });
 // FocusScope.of(context).unfocus();
  _controller.clear();
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

  void _loadData() {
    item = [];
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
        });
      });
    });
    setState(() {});
  }
}

/* --- 省略 --- */
