import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'Anki.dart';
import 'V4V2Add.dart';

class V4V2 extends StatefulWidget {
  @override
  V4V2(this.name,this.Id,this.uid);
  String name;
  String Id;
  String uid;
  State<V4V2> createState() => _V4V2State();
}

class _V4V2State extends State<V4V2> {
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
  void didUpdateWidget(V4V2 oldWidget){
    super.didUpdateWidget(oldWidget);
  }
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.name,style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {loadData();},
              icon: Icon(Icons.refresh_rounded))],),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => V4V2Add(widget.name,widget.Id,widget.uid)),).then((value) {loadData();}
            );
          },
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
                          child: Image.network(item[index][2]),
                          onPressed: () {Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Anki(item[index][0],item[index][2],item[index][1],"0","復習に追加")),
                          );},
                        ),
                      ),
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
    item1 = [];
    FirebaseFirestore.instance.collection('users').doc(widget.uid).collection("写真").doc(widget.Id).collection("写真").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        // getImgs(doc["imgId"]);
        item.add([doc["text"],doc["messageId"],doc["ImgId"]]);
        setState(() { });

        ;});  //aa();
    });

  }
  void getImgs(String imgPathRemote) async{
    if ((imgPathRemote != "") && (imgPathRemote != null)) {
      try {
        //ローカルに存在しない場合はリモートのデータをダウンロード
        imgPathUse = await FirebaseStorage.instance.ref().
        child("images").child(imgPathRemote).getDownloadURL();
        item1.add(imgPathUse);
      } catch (FirebaseException) {}} else{}
    bb();
  }
  void aa (){
    for (var i = 0; i < item.length ; i++) {
      getImgs(item[i][1]);
    }
  }
  void bb (){
    for (var i = 0; i < item.length ; i++) {
      item[i].add(item1[i]);
      setState(() { });
    }
  }
}
