
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'V1V2.dart';
import 'V2.dart';
import 'color_filters.dart';

class ankert extends StatefulWidget {
  @override
  State<ankert> createState() => _ankertState();
}

class _ankertState extends State<ankert> {
  var A1 = 0;
  var A2 = 0;
  var A3 = 0;
  var A4 = 0;
  var A5 = 0;
  var B1 = 0;
  var B2 = 0;
  var B3 = 0;
  var B4 = 0;
  var B5 = 0;
  var C1 = 0;
  var C2 = 0;
  var C3 = 0;
  var C4 = 0;
  var A = 0;
  var B  = 0;
  var C = 0;
  var D = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("アンケート",style: TextStyle(color:Colors.black),),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
              children: <Widget>[
                Container(
                    child: Text("レビューにご協力ください")),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        D = 1;
                      }, child: Text("アプリを評価")),
                ),
                Expanded(child: Column(children: [
                  Container(child: Text("次のうちのどれ？")),
                  Container(child: Row(children: [
                    ElevatedButton(onPressed: () {A = 1;A1 = A1 + 1;}, child: Text("小学生")),
                    ElevatedButton(onPressed: () {A = 1;}, child: Text("中学生")),
                    ElevatedButton(onPressed: () {A = 1;}, child: Text("高校生")),
                    ElevatedButton(onPressed: () {A = 1;}, child: Text("大学・専門")),
                    ElevatedButton(onPressed: () {A = 1;}, child: Text("その他"))
                  ],),)
                ],)),
                Expanded(child: Column(
                  children: [
                    Container(child: Text("何年生？")),
                    Container(child: Row(children: [
                      ElevatedButton(onPressed: () {}, child: Text("1年")),
                      ElevatedButton(onPressed: () {}, child: Text("2年")),
                      ElevatedButton(onPressed: () {}, child: Text("3年")),
                      ElevatedButton(onPressed: () {}, child: Text("4年")),
                      ElevatedButton(onPressed: () {}, child: Text("その他"))
                    ],),)
                  ],)),
                Expanded(child: Column(
                  children: [
                    Container(child: Text("一番の使用目的は？")),
                    Container(child: Row(children: [
                      ElevatedButton(onPressed: () {}, child: Text("定期テスト")),
                      ElevatedButton(onPressed: () {}, child: Text("受験")),
                      ElevatedButton(onPressed: () {}, child: Text("資格取得")),
                      ElevatedButton(onPressed: () {}, child: Text("その他"))
                    ],),)
                  ],)),
                Container(
                    child: Text("ありがとございました!ご要望がございましたら↓")),
                Container(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("お問い合わせ"))),
                Container(
                  child: ElevatedButton(onPressed: () {}, child: Text("終了")),
                )

              ]
          ),
        ));
  }
  Future<void> add() async {
      await FirebaseFirestore.instance
          .collection('アンケート').doc("1")// コレクションID指定
          .update({

      });
    }
}