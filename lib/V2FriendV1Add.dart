import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class V2FriendV1Add extends StatefulWidget {
  @override
  V2FriendV1Add(this.uid);
  String uid;
  State<V2FriendV1Add> createState() => _V2FriendV1AddState();
}

class _V2FriendV1AddState extends State<V2FriendV1Add> {
  @override
  bool aka = true;
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var uid = "";
  void initState() {
    super.initState();
    inputData();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("暗記ノート",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        leadingWidth: 80,),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        leading: Icon(Icons.library_books_rounded,),
                        title: Text(item[index]["kamoku"]),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                          AlertDialog(
                              title: Text("ファイルを共有しますか？",
                                textAlign: TextAlign.center,),
                              actions: <Widget>[
                          Column(
                          children: [
                          Center(
                          child: ElevatedButton(
                          child: Text('追加'),
                          onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users').doc(widget.uid).collection("友達").doc(uid) // コレクションID指定
                              .collection("写真").doc(item[index]["messageId"],)
                              .set({
                          "kamoku":item[index]["kamoku"],
                          "messageId":item[index]["messageId"],
                          "uid":uid,
                          });
                          FirebaseFirestore.instance
                              .collection('users').doc(uid).collection("友達").doc(widget.uid) // コレクションID指定
                              .collection("写真").doc(item[index]["messageId"],)
                              .set({
                          "kamoku":item[index]["kamoku"],
                          "messageId":item[index]["messageId"],
                          "uid":uid,
                          });
                          Navigator.pop(context);
                          }
                          ),
                          ),
                          CupertinoButton(
                          child: Text("キャンセル"),
                          onPressed: () {
                          Navigator.pop(context, 'cancel');
                          },)
                          ],)
                          ]));}),);},),),],),),);
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    if (id != null){
      _loadData();
    }
    return id;
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("写真").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});
      });});setState(() {});}
  String randomString(int length) {
    const _randomChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;
    final rand = new Random();
    final codeUnits = new List.generate(
      length,
          (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);},);
    return new String.fromCharCodes(codeUnits);
  }
}