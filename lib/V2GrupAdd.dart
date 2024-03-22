import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/main.dart';
import 'package:flutter/services.dart';
class V2GrupAdd extends StatefulWidget {
  @override
  _V2GrupAddState createState() => _V2GrupAddState();
}

class _V2GrupAddState extends State<V2GrupAdd> {

  String infoText = '';
  String email = '';
  String password = '';
  var uid = "";
  var name = "";
  var item = [];
  var search = false;
  var no = false;
  var myname = "";
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
        title: Text("グループを追加",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'グループのId'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });},),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('検索'),
                  onPressed: ()  {
                    Search();
                  },
                ),
              ),
              Container(
                child: Visibility(
                  visible: no,
                  child: Container(
                    child: Text("検索の結果見つかりませんでした。"),
                  ),),),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Visibility(
                  visible: search,
                  child: Container(
                    child: Text(name),
                  ),),),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Visibility(
                  visible: search,
                  child: ElevatedButton(
                    child: Text('追加'),
                    onPressed: ()  {
                      Clipboard.setData(ClipboardData(text: uid));
                      Add();
                    },
                  ),),),
            ],
          ),
        ),
      ),
    );
  }
  void Search(){
    // showProgressDialog();
    item = [];
    FirebaseFirestore.instance.collection('グループ').where('uid', isEqualTo: email).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          name = doc["name"];
          search = true;no = false;
          ;});});
    });
    setState(() {
      if (name != ""){
        search = true;no = false;
      }else{no = true; search = false;}});
    //  FocusScope.of(context).unfocus();
  }

  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
   _loadData();
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
    no = true; search = false;
    if (email != "") {
      await FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("グループ").doc(email) // ドキュメントID自動生成
          .set({
        "name":name,
        "uid":email,
      });
      await FirebaseFirestore.instance
          .collection('グループ').doc(email) // コレクションID指定
          .collection("メンバー").doc(uid) // ドキュメントID自動生成
          .set({
        "name":myname,
        "uid":email,
      });
      _controller.clear();
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
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
         myname = doc["name"];
        });
      });
    });
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