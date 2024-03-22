import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/AnkiRe.dart';
import 'package:studyroom/AnkiUse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'V4Add.dart';
import 'V4V2.dart';

class V4 extends StatefulWidget {
  @override
  State<V4> createState() => _V4State();
}

class _V4State extends State<V4> {
  // This widget is the root of your application.
  @override
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
    _getCounterValue();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("暗記ノート",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        leadingWidth: 80,
        leading:TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AnkiRe(uid)),);},
          child: Text('復習',
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {_loadData();},
              icon: Icon(Icons.refresh_rounded))
        ],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => V4Add()),).then((value) {_loadData();}
          );
        },
      ),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => V4V2(item[index]["kamoku"],item[index]["messageId"],item[index]["uid"])),
                          );
                        }
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _getCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _counter = prefs.getInt("AnkiUse3")?? 0;
    if (_counter == 0){Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => AnkiUse()));
    _setCounterValue();
    }
  }

  void _setCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("AnkiUse3", 1);
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
      });
    });
    setState(() {});
  }
}