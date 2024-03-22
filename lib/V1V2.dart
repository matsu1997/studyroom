import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'StudyRoom.dart';
import 'V1V2Add.dart';

class V1V2 extends StatefulWidget {
  @override
  V1V2(this.kamoku,this.messageId,this.uid,this.int,this.GrupId,this.FriendId);
  String kamoku;
  String messageId;
  String uid;
  String int;
  String GrupId;
  String FriendId;
  State<V1V2> createState() => _V1V2State();
}

class _V1V2State extends State<V1V2> {
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
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.kamoku,style: TextStyle(color:Colors.black),),
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
                  builder: (context) => V1V2Add(widget.kamoku,widget.messageId,widget.uid)),).then((value) {loadData();}
            );
          },
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () {Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StudyRoom(widget.kamoku,"選択なし","選択なし",widget.uid,widget.int,widget.GrupId,widget.FriendId)),
                );},
                child: Text(
                  '教材選択なし',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
              Expanded(
                child: ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                leading: Icon(Icons.library_books_rounded,),
                                title: Text(item[index][1]),
                              onTap: () {Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => StudyRoom(item[index][0],item[index][1],item[index][2],item[index][3],widget.int,widget.GrupId,widget.FriendId)),
                              );},

                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));}
  void loadData()  {
    item = [];
    item1 = [];
    FirebaseFirestore.instance.collection('users').doc(widget.uid).collection("科目").doc(widget.messageId).collection("教材").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        // getImgs(doc["imgId"]);
        item.add([widget.kamoku,doc["kyouzai"],doc["messageId"],widget.uid]);
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
