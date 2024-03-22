
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp.dart';
import 'V1Add.dart';
import 'V1V2.dart';
class remaindStudy extends StatefulWidget {
  remaindStudy(this.Id);
  String Id;
  @override
  State<remaindStudy> createState() => _remaindStudyState();
}

class _remaindStudyState extends State<remaindStudy> {
  @override
  bool aka = true;
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var uid = "";
  void initState() {
    super.initState();
    aa();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("履歴",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        leadingWidth: 80,
        actions: <Widget>[
        ],),
      body: Center(
        child: Column(
          children: <Widget>[
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
                                child:Icon(Icons.bookmarks,color:Colors.green)
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
                                    ), Expanded(
                                      child: Text(
                                        DateFormat('MM-dd - kk:mm')
                                            .format( item[index]["createdAt"].toDate())
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,color: Colors.grey
                                        ), textAlign: TextAlign.right,),),
                                  ],
                                ),
                                    Center(
                                     // margin: EdgeInsets.only( left: 10, right: 10),
                                      child: Text(
                                        '${(item[index]["count"] / (60 * 60)).floor()}:${((item[index]["count"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["count"] % (60 * 60) % 60).toString().padLeft(2, '0')}',
                                        style: TextStyle(fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  Container(
                                    margin: EdgeInsets.only( left: 10, right: 10),
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
                  );;;},),),],),),);
  }
  void aa (){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        ;} else {
        uid = user.uid;
        _loadData();
      }
    });
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(widget.Id).collection("履歴").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});
      });
    });
    setState(() {});
  }
}
