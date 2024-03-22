import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:studyroom/StudyRoom.dart';
import 'package:studyroom/V2GrupMemberAdd.dart';

import 'V1.dart';
import 'V2GrupMemberV2Add.dart';
import 'V4V2.dart';
class V2GrupMember extends StatefulWidget {
  @override
  V2GrupMember(this.uid,this.name);
  String uid;
  String name;
  State<V2GrupMember> createState() => _V2GrupMemberState();
}
enum Menu {copy }
class _V2GrupMemberState extends State<V2GrupMember> {
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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:Text(widget.name,style: TextStyle(color:Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton(
                onSelected: popupMenuSelected,
                icon:Icon(Icons.line_weight_sharp),
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Menu>>[
                  const PopupMenuItem( child: const ListTile( leading:Icon(Icons.copyright),
                      title:Text("IDをコピー")), value: Menu.copy,),
                ],)
            ],
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("メンバー",style: TextStyle(fontSize: 11,color:Colors.black),),),
                Tab(child: Text("ノート",style: TextStyle(fontSize: 11,color:Colors.black),),),
                Tab(child: Text("勉強",style: TextStyle(fontSize: 11,color:Colors.black)),),
                Tab(child: Text("チャット",style: TextStyle(fontSize: 11,color:Colors.black),),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              V2GrupMemberV1(widget.uid,widget.name),
              V2GrupMemberV2(widget.uid),
              V2GrupMemberV3(widget.uid),
              V2GrupMemberV4(widget.uid),
            ],
          ),
        ),
      ),
    );
  }
  void popupMenuSelected(Menu selectedMenu){
    switch(selectedMenu) {
      case Menu.copy:Clipboard.setData(ClipboardData(text: widget.uid));
      break;
      default:
        break;
    }}
}




class V2GrupMemberV1 extends StatefulWidget {
  @override
  V2GrupMemberV1(this.uid,this.name);
  String uid;
  String name;
  State<V2GrupMemberV1> createState() => _V2GrupMemberV1State();
}
class _V2GrupMemberV1State extends State<V2GrupMemberV1> {
  @override
  var item = [];
  var uid = "";
  var name = "";
  void initState() {
    super.initState();
    _loadData();
    inputData();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
        Container(
        margin: EdgeInsets.only( top:20),
        child: ElevatedButton(
            child: Text('友達をグループに招待'),
          onPressed: () {     Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => V2GrupMemberAdd(widget.uid,widget.name)),
          ); ;})
            ),
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        leading: Icon(Icons.account_circle,),
                        title: Text(item[index]["name"]),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    title: Text("友達申請しますか？",
                                      textAlign: TextAlign.center,),
                                    actions: <Widget>[
                                      Column(
                                        children: [
                                          Center(
                                            child: ElevatedButton(
                                                child: Text('申請'),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users').doc(
                                                      item[index]["uid"]) // コレクションID指定
                                                      .collection("友達招待中").doc(
                                                      uid) // ドキュメントID自動生成
                                                      .set({
                                                    "uid": uid,
                                                    "name": name,
                                                  });
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
                        }),);
                },),),
          ],),),);
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData1();
    return id;
  }
  void _loadData1() {
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
  void _loadData() {
    item = [];
    FirebaseFirestore.instance.collection('グループ').doc(widget.uid).collection(
        "メンバー").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);});});});
    setState(() {});
  }
}

class V2GrupMemberV2 extends StatefulWidget {
  @override
  V2GrupMemberV2(this.uid);
  String uid;
  State<V2GrupMemberV2> createState() => _V2GrupMemberV2State();
}

class _V2GrupMemberV2State extends State<V2GrupMemberV2> {
  @override
  var item = [];
  var uid = "";
  void initState() {
    super.initState();
    _loadData();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => V2GrupMemberV2Add(widget.uid)),).then((value) {_loadData();}
          );
        },
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only( top:20),
            ),
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
                        }),);},),),],),),);
  }

  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('グループ').doc(widget.uid).collection("写真").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});
      });
    });
    setState(() {});
  }
}

//3
class V2GrupMemberV3 extends StatefulWidget {
  @override
  V2GrupMemberV3(this.uid);
  String uid;
  State<V2GrupMemberV3> createState() => _V2GrupMemberV3State();
}
class _V2GrupMemberV3State extends State<V2GrupMemberV3> {
  @override
  var item = [];
  var uid = "";
  void initState() {
    super.initState();
    _loadData();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only( top:20),
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
                                child:Icon(Icons.account_circle,color:Colors.green)
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only( left: 5, right: 5),
                                          child: Text(
                                            item[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),),),
                                        Expanded(
                                         // margin: EdgeInsets.only( left: 5, right: 5),
                                          child: Text(
                                            textAlign: TextAlign.right,
                                              DateFormat('yyyy-MM-dd - kk:mm')
                                                  .format( item[index]["createdAt"].toDate())
                                                  .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,color: Colors.grey
                                            ),),),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only( left: 5, right: 5),
                                      child: Text(
                                        '${(item[index]["count"] / (60 * 60)).floor()}:${((item[index]["count"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["count"] % (60 * 60) % 60).toString().padLeft(2, '0')}　勉強しました!',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ],)
                            ),],)
                    ),
                  );},),),
            Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => V1("1",widget.uid,"")),).then((value) {_loadData();}
                  );},
                  child: Text(
                    '勉強スタート',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
          ],),),);
  }

  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('グループ').doc(widget.uid).collection("勉強").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});
      });
    });
    setState(() {});
  }
}


//V4

class V2GrupMemberV4 extends StatefulWidget {
  V2GrupMemberV4(this.uid);
  String uid;
  @override
  State<V2GrupMemberV4> createState() => _V2GrupMemberV4State();
}

class _V2GrupMemberV4State extends State<V2GrupMemberV4> {
  var item = [];
  var uid = "";
  var user = "";
  var co = 0;
  get onEng => null;
  var name = "";
  late TextEditingController _bodyController;
  void initState() {
    super.initState();
    inputData();
    _bodyController = TextEditingController();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only( top:20),
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
                                child:Icon(Icons.person,color:Colors.green)
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only( left:5, right: 5),
                                          child: Text(
                                            item[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                         // margin: EdgeInsets.only( left: 5, right: 5),
                                          child: Text(
                                            textAlign: TextAlign.right,
                                            DateFormat('yyyy-MM-dd - kk:mm')
                                                .format( item[index]["createdAt"].toDate())
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,color: Colors.grey
                                            ),),),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only( top: 5,left: 5, right: 5),
                                      child: Text(
                                        item[index]["text"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 10
                                        ),
                                      ),
                                    ),
                                  ],)
                            ),],)
                    ),
                  );},),),
            Container(
                height: 100,
                child:Row(
                  children: <Widget>[
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: TextField(
                        controller: _bodyController,
                        decoration: InputDecoration(hintText: 'text'),
                      ),
                    ),
                    CupertinoButton(
                      child: Text("送る"),
                      onPressed: () {
                        send();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                    )
                  ],
                )
            )
          ],),),);}
  void inputData() {
    final user = FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData1();
  }
  void _loadData()  {
    item = [];
    inputData();
    FirebaseFirestore.instance.collection('グループ').doc(widget.uid).collection("チャット").orderBy('createdAt', descending: true).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          ;});});});
    if (item.length == 0){
      setState(() {   item = [];   });
    }
  }
  Future<void> send() async {
    var aa = randomString(20);
    await FirebaseFirestore.instance
        .collection('グループ').doc(widget.uid)// コレクションID指定
        .collection("チャット").doc(aa)
        .set({
      "text" : _bodyController.text,
      "name":name,
      "createdAt": Timestamp.now(),
    });
    setState(() {_loadData();});
    _bodyController.clear();
  }
  void _loadData1() {
    item = [];
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
  String randomString(int length) {
    const _randomChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;
    final rand = new Random();
    final codeUnits = new List.generate(
      length,
          (index) {
        final n = rand.nextInt(_charsLength);
        return _randomChars.codeUnitAt(n);
      },);
    return new String.fromCharCodes(codeUnits);
  }

}