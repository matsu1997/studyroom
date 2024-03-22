

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'fab_animation.dart';
class Anki extends StatefulWidget {
  Anki(this.text, this.ImgId, this.messageId,this.Page,this.textRe);

  String text;
  String ImgId;
  String messageId;
  String Page;
  String textRe;


  @override
  State<Anki> createState() => _AnkiState();
}

class _AnkiState extends State<Anki> {
  // This widget is the root of your application.
  @override
  bool aka = true;
  var uid = "";
  var co = 0;
  var coRe = 0;
  var coColor = 0;
  var colorbid = 0.04;
  var color = Colors.red;
  var barText = "";
  var text = "シートOFF";
  var textColor = "緑";
  var position = const Offset(0, 0);
  double top = 100.0 as double;
  double bottom = 60.0 as double;
  double left = 0.0 as double;
  double right = 0.0 as double;
  double mediaWidth = 80;
  double scaleWidthFactor = 1;
  double minWidth = 40;
  double maxWidth = 160;
  void initState() {
    super.initState();
    inputData();
    barText = widget.text;
  }
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.text,style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        floatingActionButton: ExpandableFab(
          distance: 112.0,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (co == 0) {
                    text = "シートON";
                    aka = false;
                    co = 1;
                  } else {
                    text = "シートOFF";
                    aka = true;
                    co = 0;
                  }
                });},
              label: Text(text),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (widget.Page == "0"){
                    if (coRe == 0) {
                      widget.textRe = "追加済み";
                      add();
                      coRe = 1;}
                  }else{
                    if (coRe == 0) {
                      widget.textRe = "削除済み";
                      delete();
                      coRe = 1;}
                  }
                });},
              label: Text(widget.textRe),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (coColor == 0) {
                    textColor = "赤";
                    color = Colors.green;
                    coColor = 1;
                  } else {
                    textColor = "緑";
                    color = Colors.red;
                    coColor = 0;
                  }
                });
              },
              label: Text(textColor),
            ),
          ],
        ),
        body: new Container(
          height: 10000.0,
          width: 10000,
          child:Stack(
            children: <Widget>[
              InteractiveViewer(
                constrained: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2500.0,
                      width: 500,
                      child:Container(
                          alignment: Alignment(0.0, -0.7),
                          child:Image.network(widget.ImgId)
                      ),
                    ),
                  ],
                ),
              ),

              new IgnorePointer(
                ignoring: true,
                child: Stack(children: <Widget>[
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                  new Center(
                    child: Visibility(
                      visible: aka,
                      child: Container(
                        margin: new EdgeInsets.only(
                            top: top, bottom: bottom, left: left, right: right),
                        color: color[900]?.withOpacity(colorbid),
                      ),
                    ),
                  ),
                ]),),
            ],
            // fit: StackFit.expand
          ),)
    );
  }

  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    return id;
  }
  Future<void> add() async {
    var aa =  randomString(20);
    await FirebaseFirestore.instance
        .collection('users').doc(uid)// コレクションID指定
        .collection("暗記復習").doc(aa)// ドキュメントID自動生成
        .set({
      "messageId" : aa,
      "ImgId": widget.ImgId,
      "text":widget.text
    });
  }
  Future<void> delete() async {
    print(widget.messageId);
    await FirebaseFirestore.instance
        .collection('users').doc(uid)// コレクションID指定
        .collection("暗記復習").doc(widget.messageId).delete();
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
