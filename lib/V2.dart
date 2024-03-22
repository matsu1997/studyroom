import 'dart:math';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:studyroom/V2GruoCreate.dart';
import 'Acount.dart';
import 'V2FriendPage.dart';
import 'V2FriendAdd.dart';
import 'V2GrupAdd.dart';
import 'V2GrupMember.dart';
import 'delete.dart';
import 'fab_animation.dart';
import 'mail.dart';
import 'package:flutter_share/flutter_share.dart';


class V2 extends StatefulWidget {
  @override
  State<V2> createState() => _V2State();
}
enum Menu { Edite,login,request, iphone,android ,message }
class _V2State extends State<V2> {
  // This widget is the root of your application.
  @override
  @override
  bool aka = true;
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var uid = "";
  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
  void initState() {
    super.initState();
    // Can't show a dialog in initState, delaying initialization
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('友だちリスト',style: TextStyle(color:Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("友だちリスト",style: TextStyle(fontSize: 11,color:Colors.black),),),
                Tab(child: Text("グループ",style: TextStyle(fontSize: 11,color:Colors.black),)),
              ],
            ),
            actions: [
              PopupMenuButton(
                onSelected: popupMenuSelected,
                icon:Icon(Icons.account_circle,color: Colors.black,),
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Menu>>[
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.account_circle),
                      title:Text("アカウントを編集")), value: Menu.Edite,),
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.account_circle),
                      title:Text("アカウントを削除")), value: Menu.login,),
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.star),
                      title:Text("このアプリを評価する")), value: Menu.request),
                  // const PopupMenuItem( child: const ListTile( leading:Icon(Icons.apple),
                  //     title:Text("友達に薦める(iphone)")), value: Menu.iphone,),
                  // const PopupMenuItem( child: const ListTile( leading:Icon(Icons.android),
                  //     title:Text("友達に薦める(android)")), value: Menu.android,),
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.mail),
                      title:Text("お問い合わせ")), value: Menu.message,),
                ],
              )
            ],
          ),
          body: TabBarView(
            children: [
              V2Friend(),
              V2Grup(),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _requestReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
  void popupMenuSelected(Menu selectedMenu){
    switch(selectedMenu) {
      case Menu.Edite:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Acount()));
        break;
      case Menu.login:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => delete()));
        break;
      case Menu.request: _requestReview();
      break;
      case Menu.iphone:
        break;
      case Menu.android:
        break;
      case Menu.message:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => mail()));
        break;
      default:
        break;
    }}
  //void _share() {Share.share('共有するテキスト');}
}


class V2Friend extends StatefulWidget {
  @override
  // V2Friend(this.Kamoku, this.Kyouzai,this.messageId, this.uid);
  //
  // String Kamoku;
  // String Kyouzai;
  // String messageId;
  // String uid;
  State<V2Friend> createState() => _V2FriendState();
}

class _V2FriendState extends State<V2Friend> {
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var item1 = [];
  var uid = "";
  var text = "";
  var name = "";
  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => V2FriendAdd()),).then((value) {_loadData();}
            );
          },
        ),
        body: Column(children: [
          Container(
           child: Text(text),
          ),
          Container(
            height: item1.length * 60 ,
            child: ListView.builder(
              itemCount: item1.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.person,
                      ),
                      title: Text(item1[index]["name"]),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text("友達に追加しますか？",
                                    textAlign: TextAlign.center,),
                                  actions: <Widget>[
                                    Column(
                                      children: [
                                        Center(
                                          child: ElevatedButton(
                                              child: Text('追加'),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('users').doc(
                                                    uid) // コレクションID指定
                                                    .collection("友達").doc(
                                                    item1[index]["uid"]) // ドキュメントID自動生成
                                                    .set({
                                                  "uid": item1[index]["uid"],
                                                  "name": item1[index]["name"],
                                                });
                                                FirebaseFirestore.instance
                                                    .collection('users').doc(
                                                    item1[index]["uid"]) // コレクションID指定
                                                    .collection("友達").doc(
                                                    uid) // ドキュメントID自動生成
                                                    .set({
                                                  "uid": uid,
                                                  "name": name,
                                                });
                                                FirebaseFirestore.instance
                                                    .collection(
                                                    "users").doc(uid).collection(
                                                    "友達招待中")
                                                    .doc(item1[index]["uid"])
                                                    .delete();
                                                Navigator.pop(context, '');
                                                _loadData();_loadData1();
                                                setState(() {});
                                              }
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                              child: Text('断る'),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                    "users").doc(uid).collection(
                                                    "友達招待中")
                                                    .doc(item1[index]["uid"])
                                                    .delete();
                                                _loadData();_loadData1();
                                                setState(() {});
                                                Navigator.pop(context, '');
                                              }
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text("キャンセル"),
                                          onPressed: () {
                                            Navigator.pop(context, 'cancel');
                                          },
                                        )
                                      ],)
                                  ],));
                      }),
                );
              },
            ),
          ),
          Container(
            child: Text("友達"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.person,
                      ),
                      title: Text(item[index]["name"]),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => V2FriendPage(item[index]["uid"],item[index]["name"])),
                        );
                      }),
                );
              },
            ),
          ),
        ]));
  }

  Future<String> inputData() async {
    final user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    if (id != null) {
      _loadData();
      _loadData1();
      _loadData2();
    }
    return id;
  }

  void _loadData() {
    item = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("友達")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;
        });
      });
    });
    setState(() {});
  }
  void _loadData1() {
    item1 = [];
    text = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("友達招待中")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          text = "友達申請中";
          item1.add(doc);
        });
      });
    });
    setState(() {});
  }
  void _loadData2() {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          name = doc["name"];
        });});});
  }
}

class V2Grup extends StatefulWidget {
  @override
  _V2GrupState createState() => _V2GrupState();
}

class _V2GrupState extends State<V2Grup> {
  var co = 0;
  var colorbid = 0.01;
  var color = Colors.red;
  var item = [];
  var uid = "";
  var item1 = [];
  var text = "";
  var name = "";
  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
        floatingActionButton: ExpandableFab(distance: 70.0, children: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => V2GrupAdd(),),).then((value) {_loadData();});
            },
            label: Text("グループに参加"),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => V2GrupCreate(),),).then((value) {_loadData();});
            },
            label: Text("グループを作成"),
          ),
        ]),
        body: Column(children: [
          Container(
            child: Text(text),
          ),
          Container(
            height: item1.length * 60 ,
            child: ListView.builder(
              itemCount: item1.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.people_alt,
                      ),
                      title: Text(item1[index]["name"]),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text("グループを追加しますか？",
                                    textAlign: TextAlign.center,),
                                  actions: <Widget>[
                                    Column(
                                      children: [
                                        Center(
                                          child: ElevatedButton(
                                              child: Text('追加'),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('users').doc(
                                                    uid) // コレクションID指定
                                                    .collection("グループ").doc(
                                                    item1[index]["uid"]) // ドキュメントID自動生成
                                                    .set({
                                                  "uid": item1[index]["uid"],
                                                  "name": item1[index]["name"],
                                                });
                                                FirebaseFirestore.instance
                                                    .collection('グループ').doc(
                                                    item1[index]["uid"]) // コレクションID指定
                                                    .collection("メンバー").doc(
                                                   uid) // ドキュメントID自動生成
                                                    .set({
                                                  "uid": uid,
                                                  "name": name,
                                                });
                                                FirebaseFirestore.instance
                                                    .collection(
                                                    "users").doc(uid).collection(
                                                    "グループ招待中")
                                                    .doc(item1[index]["uid"])
                                                    .delete();
                                                Navigator.pop(context, '');
                                                _loadData();_loadData1();
                                                setState(() {});
                                              }
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                              child: Text('断る'),
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                    "users").doc(uid).collection(
                                                    "グループ招待中")
                                                    .doc(item1[index]["uid"])
                                                    .delete();
                                                _loadData();_loadData1();
                                                setState(() {});
                                                Navigator.pop(context, '');
                                              }
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text("キャンセル"),
                                          onPressed: () {
                                            Navigator.pop(context, 'cancel');
                                          },
                                        )
                                      ],)
                                  ],));
                      }),
                );
              },
            ),
          ),
          Container(
            child: Text("グループ"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.people_alt,
                      ),
                      title: Text(item[index]["name"]),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>  V2GrupMember(item[index]["uid"],item[index]["name"])),
                        );
                      }),
                );
              },
            ),
          ),
        ]));
  }

  Future<String> inputData() async {
    final user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    if (id != null) {
      _loadData();
      _loadData1();
      _loadData2();
    }
    return id;
  }

  void _loadData() {
    item = [];
    text = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("グループ")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;
        });
      });
    });
    setState(() {});
  }
  void _loadData1() {
    item1 = [];
    text = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("グループ招待中")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          text = "グループ招待中";
          item1.add(doc);
        });
      });
    });
    setState(() {});
  }
  void _loadData2() {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          name = doc["name"];
        });});});
  }
}
