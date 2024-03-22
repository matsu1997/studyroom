
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp.dart';
import 'V1Add.dart';
import 'V1V2.dart';
import 'delete.dart';
import 'mail.dart';
class V1 extends StatefulWidget {
  V1(this.int,this.GrupId,this.FriendId);
  String int;
  String GrupId;
  String FriendId;
  @override
  State<V1> createState() => _V1State();
}
enum Menu { login,request, iphone,android ,message }
class _V1State extends State<V1> {
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
   // _getCounterValue();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("勉強科目",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {_loadData();},
              icon: Icon(Icons.refresh_rounded))
        ],),
      floatingActionButton: FloatingActionButton(
      //  backgroundColor: Colors.brown,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => V1Add()),).then((value) {_loadData();}
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
                        builder: (context) => V1V2("選択なし","選択なし",uid,widget.int,widget.GrupId,widget.FriendId)),
                  );},
                  child: Text(
                    '科目選択なし',
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
                        title: Text(item[index]["kamoku"]),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => V1V2(item[index]["kamoku"],item[index]["messageId"],item[index]["uid"],widget.int,widget.GrupId,widget.FriendId)),
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
  // void _getCounterValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var _counter = prefs.getInt("AnkiUse3")?? 0;
  //   if (_counter == 0){
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //           builder: (context) => AnkiUse()));
  //   _setCounterValue();
  //   }
  // }
  void aa (){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Future(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SignUp();
          }));})
        ;} else {
        print('User is signed in!');
        uid = user.uid;
        _loadData();
      }
    });
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("科目").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});
      });
    });
    setState(() {});
  }

}
