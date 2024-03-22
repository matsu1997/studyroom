import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studyroom/remaindStudy.dart';
import 'StudyRoom.dart';
import 'countdown-page.dart';
import 'fab_animation.dart';

class remaind extends StatefulWidget {
  @override
  State<remaind> createState() => _remaindState();
}

class _remaindState extends State<remaind> {
  late Timer _timer;
  late DateTime _time;
  var count = 0;
  var co = 0;
  bool stop = true;
  bool countdown = true;
  var date1 = "";
  var date2 = "";
  var date3 = "";
  var date4 = "";
  @override
  void initState() {
    // 初期化処理
    _time = DateTime.utc(0, 0, 0);
    super.initState();
    date();
  }

  Duration timerDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => remaindStudy("All")),);},
                child: Text('全体履歴',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ],
            title:  Text("おすすめの復習",style: TextStyle(color:Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            bottom:  TabBar(
              tabs: [
                Tab(child: Text("1回目",style: TextStyle(color:Colors.black),)),
          Tab(child: Text("2回目",style: TextStyle(color:Colors.black),),),
          Tab(child: Text("3回目",style: TextStyle(color:Colors.black),),),
          Tab(child: Text("4回目",style: TextStyle(color:Colors.black),),),]
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child:TabBarView(
                children: [
                  R1(),
                  R2(),
                  R3(),
                  R4(),
                ],
              ),),Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                child: Text("エビングハウス忘却曲線から算出",style: TextStyle(color: Colors.grey),),
              )]
          )
        ),
      ),
    );
  }
  void date() {
    setState(() {
    DateTime now = DateTime.now();
    final DateTime date11 = now.add(Duration(days: 1) * -1);
    date1 = DateFormat('MM月dd日').format(date11);
    final DateTime date22 = now.add(Duration(days: 8) * -1);
    date2 = DateFormat('MM月dd日').format(date22);
    final DateTime date33 = now.add(Duration(days: 22) * -1);
    date3 = DateFormat('MM月dd日').format(date33);
    final DateTime date44 = now.add(Duration(days: 52) * -1);
    date4 = DateFormat('MM月dd日').format(date44);});
  }
}

class  R1 extends StatefulWidget {
  @override
  State<R1> createState() => _R1State();
}
class _R1State extends State<R1> {
  var item = [];
  var date = "";
  var uid = "";
  @override
  void initState() {
    super.initState();
    date1();
  }
  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
        body: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
            child:Text(date + "に学習",style: TextStyle(fontSize: 20),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.grey[100],
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:[Colors.white,Colors.white ],//[Colors.redAccent, Colors.red],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child:Row(
                        children: [
                          Container(
                              width: 50,
                              child:Icon(Icons.library_books_rounded,color:Colors.green)
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item[index]["kamoku"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,fontSize: 20
                                          ),),),
                                      Expanded(
                                        child: Text(
                                          item[index]["kyouzai"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,fontSize: 20
                                          ),),),
                                      Expanded(
                                        child: Text(
                                          '${(item[index]["count"] / (60 * 60)).floor()}:${((item[index]["count"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["count"] % (60 * 60) % 60).toString().padLeft(2, '0')}',
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20
                                          ),),),],),
                                  Center(
                                   // margin: EdgeInsets.only( left: 10, right: 10),
                                    child:Text(item[index]["coment"],
                                      style: TextStyle(
                                        fontSize: 20,color: Colors.grey,
                                        // color: Colors.white,
                                      ),),)],)
                          ),],)
                  ),
                );;;},),),],
            ),
          );
  }
  void date1() {
    DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.add(Duration(days: 1) * -1);
    date = DateFormat('yyyy年MM月dd日').format(thirtyDaysAgo);
    print(date);
    inputData();
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData();
    return id;
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(date).collection("履歴").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});});});
  }
}


class  R2 extends StatefulWidget {
  @override
  State<R2> createState() => _R2State();
}
class _R2State extends State<R2> {
  var item = [];
  var date = "";
  var uid = "";
  @override
  void initState() {
    super.initState();
    date1();
  }
  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child:Text(date + "に学習",style: TextStyle(fontSize: 20),),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.grey[100],
                elevation: 8,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:[Colors.white,Colors.white ],//[Colors.redAccent, Colors.red],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child:Row(
                      children: [
                        Container(
                            width: 50,
                            child:Icon(Icons.library_books_rounded,color:Colors.green)
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item[index]["kamoku"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 20
                                        ),),),
                                    Expanded(
                                      child: Text(
                                        item[index]["kyouzai"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 20
                                        ),),),
                                    Expanded(
                                      child: Text(
                                        '${(item[index]["count"] / (60 * 60)).floor()}:${((item[index]["count"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["count"] % (60 * 60) % 60).toString().padLeft(2, '0')}',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20
                                        ),),),],),
                                Center(
                                  // margin: EdgeInsets.only( left: 10, right: 10),
                                  child:Text(item[index]["coment"],
                                    style: TextStyle(
                                      fontSize: 20,color: Colors.grey,
                                      // color: Colors.white,
                                    ),),)],)
                        ),],)
                ),
              );;;},),),],
      ),
    );
  }
  void date1() {
    DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.add(Duration(days: 8) * -1);
    date = DateFormat('yyyy年MM月dd日').format(thirtyDaysAgo);
    print(date);
    inputData();
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData();
    return id;
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(date).collection("履歴").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});});});
  }
}


class  R3 extends StatefulWidget {
  @override
  State<R3> createState() => _R3State();
}
class _R3State extends State<R3> {
  var item = [];
  var date = "";
  var uid = "";
  @override
  void initState() {
    super.initState();
    date1();
  }
  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child:Text(date + "に学習",style: TextStyle(fontSize: 20),),
        ),
    Expanded(
    child: ListView.builder(
    itemCount: item.length,
    itemBuilder: (context, index) {
    return Card(
    shadowColor: Colors.grey[100],
    elevation: 8,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
    ),
    child: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors:[Colors.white,Colors.white ],//[Colors.redAccent, Colors.red],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
    ),
    padding: EdgeInsets.all(16),
    child:Row(
    children: [
    Container(
    width: 50,
    child:Icon(Icons.library_books_rounded,color:Colors.green)
    ),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Expanded(
    child: Text(
    item[index]["kamoku"],
    style: TextStyle(
    fontWeight: FontWeight.bold,fontSize: 20
    ),),),
    Expanded(
    child: Text(
    item[index]["kyouzai"],
    style: TextStyle(
    fontWeight: FontWeight.bold,fontSize: 20
    ),),),
    Expanded(
    child: Text(
    '${(item[index]["count"] / (60 * 60)).floor()}:${((item[index]["count"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["count"] % (60 * 60) % 60).toString().padLeft(2, '0')}',
    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20
    ),),),],),
    Center(
    // margin: EdgeInsets.only( left: 10, right: 10),
    child:Text(item[index]["coment"],
    style: TextStyle(
    fontSize: 20,color: Colors.grey,
    // color: Colors.white,
    ),),)],)
    ),],)
    ),
    );;;},),),],
      ),
    );
  }
  void date1() {
    DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.add(Duration(days: 22) * -1);
    date = DateFormat('yyyy年MM月dd日').format(thirtyDaysAgo);
    print(date);
    inputData();
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData();
    return id;
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(date).collection("履歴").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});});});
  }
}


class  R4 extends StatefulWidget {
  @override
  State<R4> createState() => _R4State();
}
class _R4State extends State<R4> {
  var item = [];
  var date = "";
  var uid = "";
  @override
  void initState() {
    super.initState();
    date1();
  }
  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child:Text(date + "に学習",style: TextStyle(fontSize: 20),),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.grey[100],
                elevation: 8,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:[Colors.white,Colors.white ],//[Colors.redAccent, Colors.red],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child:Row(
                      children: [
                        Container(
                            width: 40,
                            child:Icon(Icons.library_books_rounded,color:Colors.green)
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only( left: 10, right: 10),
                                      child: Text(
                                        item[index]["kamoku"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only( left: 10, right: 10),
                                      child: Text(
                                        item[index]["kyouzai"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only( left: 10, right: 10),
                                      child: Text(
                                        '${(item[index]["count"] / (60 * 60)).floor()}:${((item[index]["count"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["count"] % (60 * 60) % 60).toString().padLeft(2, '0')}',
                                        style: TextStyle(fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                 // margin: EdgeInsets.only( left: 10, right: 10),
                                  child:Text(item[index]["coment"],
                                    style: TextStyle(
                                      fontSize: 20,color: Colors.grey,
                                      // color: Colors.white,
                                    ),
                                  ),
                                )
                              ],)
                        ),],)
                ),
              );
            },
          ),
        ),],
      ),
    );
  }
  void date1() {
    DateTime now = DateTime.now();
    final DateTime thirtyDaysAgo = now.add(Duration(days: 52) * -1);
    date = DateFormat('yyyy年MM月dd日').format(thirtyDaysAgo);
    print(date);
    inputData();
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData();
    return id;
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(date).collection("履歴").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});});});
  }
}