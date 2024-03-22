import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'Anki.dart';
import 'V4V2Add.dart';

class AnkiRe extends StatefulWidget {
  @override
  AnkiRe(this.uid);
  // String name;
  // String Id;
  String uid;
  State<AnkiRe> createState() => _AnkiReState();
}

class _AnkiReState extends State<AnkiRe> {
  // This widget is the root of your application.
  @override
  @override
  bool aka = true;
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var item1 = [];
  String imgPathUse="";
  void initState() {
    super.initState();
    loadData();
  }
  @override
  void didUpdateWidget(AnkiRe oldWidget){
    super.didUpdateWidget(oldWidget);
  }
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("暗記ノート復習",style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
            onPressed: () {loadData();},
            icon: Icon(Icons.refresh_rounded)
          )],
        ),
        body: GridView.count(
            padding: EdgeInsets.all(4.0),
            crossAxisCount: 2,
            crossAxisSpacing: 10.0, // 縦
            mainAxisSpacing: 10.0, // 横
            childAspectRatio: 0.7, // 高さ
            shrinkWrap: true,
            children: List.generate(item.length, (index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      offset: new Offset(5.0, 5.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child:Column(
                    children: <Widget>[
                      Expanded(
                          child:MaterialButton(
                              padding: EdgeInsets.all(3.0),
                              textColor: Colors.black,
                              elevation: 8.0,
                              child: Image.network(item[index][1]),
                              onPressed: () {Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Anki(item[index][0],item[index][1],item[index][2],"1","復習から削除")),
                              );},
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                            title: Text("暗記復習から削除しますか？"),
                                            content: Text("写真が消える訳ではありません"),
                                            actions: <Widget>[
                                              GestureDetector(
                                                child: Text('いいえ'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },),
                                              GestureDetector(
                                                child: Text('はい'),
                                                onTap: () {
                                                  setState(() {});
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                      "users").doc(widget.uid).collection(
                                                      "暗記復習")
                                                      .doc(item[index][2])
                                                      .delete();
                                                  Navigator.pop(context);
                                                  loadData();
                                                },
                                              )]));
                              })),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(item[index][0]
                        ),
                      ),
                    ]
                ),
              );

            }
            ))
    );
  }
  void loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(widget.uid).collection("暗記復習").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        // getImgs(doc["messageId"]);
        item.add([doc["text"],doc["ImgId"],doc["messageId"]]);
        print(item);
        print("item");
        ;});
      if(item.length != 0){
        setState(() { });}
    });
    setState(() { });
  }
}
