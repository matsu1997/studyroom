import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../round-button.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:timezone/timezone.dart' as tz;
class CountdownPage extends StatefulWidget {
  CountdownPage(this.Kamoku, this.Kyouzai,this.messageId, this.uid,this.int,this.GrupId,this.FriendId);

  String Kamoku;
  String Kyouzai;
  String messageId;
  String uid;
  String int;
  String GrupId;
  String FriendId;
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin , WidgetsBindingObserver {
  late AnimationController controller;
  var _controller = TextEditingController();
  bool isPlaying = false;
  late DateTime  now;
  late DateTime  now1;
  var dif = 0;
  var  second = 0;
  var start = 0;
  late Duration count ;
  String get countText {
     count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';

  }
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    date1();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1500)
    );
    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }});}

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    controller.dispose();
    super.dispose();
    final flnp = FlutterLocalNotificationsPlugin();
    flnp.cancel(0);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stete = $state");
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused: second = count.inSeconds;main();
      break;
      case AppLifecycleState.resumed:
       main1();
      break;
      case AppLifecycleState.detached:
        break;
    }
  }
  void main() {
    now = DateTime.now();
  }
  void main1() {
    if (start == 1){
      start = 0;
      now1 = DateTime.now();
      dif = now1.difference(now).inSeconds;
      var sum = second - dif;
      if (sum < 0){
        DateAdd();
        switch (widget.int){
          case "0":
            break;
          case "1":
            Grup();
            break;
          case "2":
            Friend();
            break;
        }
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text("履歴を残しますか？" ,textAlign: TextAlign.center,),
                  content: Text(time0,textAlign: TextAlign.center,),
                  actions: <Widget>[
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text(widget.Kamoku), Text("  :  "),Text(widget.Kyouzai)],
                        ),
                        Container(
                          child:TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(labelText: 'コメント(ページ数など)'),
                            onChanged: (String value) {
                              setState(() {email = value;});},),),
                        Container(
                          child: ElevatedButton(
                            child: Text('追加'),
                            onPressed: ()  {
                              Add();
                              Navigator.pop(context, '');
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: Text("キャンセル"),
                          onPressed: () {
                            Navigator.pop(context, 'cancel');
                          },
                        )
                      ],)],));}else{}
    }}

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  double progress = 1.0;
  var email = "";
  var date = "";
  var uid = "";
  var item = [];
  var count2 = 0;
  var count3 = 0;
  var Monthcount= 0;
  var Monthco= 0;
  var Allco= 0;
  var Kamokuco = 0;
  var Month = "";
  var kaisu = 0;
  var Allcount= 0;
  var Kamokucount = 0;
  var time = 0;
  var co = 0;
  var time0 = "";
  var name = "";
  void notify() {
    time = controller.duration!.inSeconds;
    time0 = '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}';
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
      if (co == 0){
        co = 1;
        count3 = count3 + time;
        Monthcount = Monthcount + time;
        Allcount =  Allcount + time;
        Kamokucount = Kamokucount + time;
        kaisu = kaisu + 1;
        DateAdd();
        switch (widget.int){
          case "0":
            break;
          case "1":
            Grup();
            break;
          case "2":
            Friend();
            break;
        }
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text("履歴を残しますか？" ,textAlign: TextAlign.center,),
                content: Text(time0,textAlign: TextAlign.center,),
                actions: <Widget>[
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text(widget.Kamoku), Text("  :  "),Text(widget.Kyouzai)],
                      ),
                      Container(
                        child:TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(labelText: 'コメント(ページ数など)'),
                          onChanged: (String value) {
                            setState(() {email = value;});},),),
                      Container(
                        child: ElevatedButton(
                          child: Text('追加'),
                          onPressed: ()  {
                            Add();
                            Navigator.pop(context, '');
                          },
                        ),
                      ),
                      CupertinoButton(
                        child: Text("キャンセル"),
                        onPressed: () {
                          Navigator.pop(context, 'cancel');
                        },
                      )
                    ],)],));}else{}
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,//Color(0xfff5fbff),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    value: progress,
                    strokeWidth: 6,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 300,
                          child: CupertinoTimerPicker(
                            initialTimerDuration: controller.duration!,
                            onTimerDurationChanged: (time) {
                              setState(() {
                                controller.duration = time;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    co = 0;
                    if (controller.isAnimating) {
                      controller.stop();
                      final flnp = FlutterLocalNotificationsPlugin();
                      flnp.cancel(0);
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      notify1();
                      notify2();
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    color:Colors.blueAccent,
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    start = 0;
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: RoundButton(
                    color: Colors.blueAccent,
                    icon: Icons.stop,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> notify1() {
    final flnp = FlutterLocalNotificationsPlugin();
    return flnp.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    ).then((_) => flnp.zonedSchedule(0, 'お疲れ様でした！', '',
      tz.TZDateTime.now(tz.UTC).add(Duration(seconds: count.inSeconds)),
      NotificationDetails(
        android: const AndroidNotificationDetails(
          'スタディルーム',
          'お疲れ様でした！',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    )
    );
  }

  Future<void> notify2() {
    final flnp = FlutterLocalNotificationsPlugin();
    return flnp.initialize(
      InitializationSettings(
        iOS: IOSInitializationSettings(),
      ),
    ).then((_) => flnp.zonedSchedule(0, 'お疲れ様でした！', '',
      tz.TZDateTime.now(tz.UTC).add(Duration(seconds: count.inSeconds)),
      NotificationDetails(
        iOS:  IOSNotificationDetails(
          // 'スタディルーム',
          // 'お疲れ様でした！',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    ));
  }


  void Grup() {
    var aa = randomString(10);
    FirebaseFirestore.instance
        .collection('グループ').doc(widget.GrupId) // コレクションID指定
        .collection("勉強").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "name":name,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });}
  void Friend(){
    var aa = randomString(10);
    FirebaseFirestore.instance
        .collection('users').doc(uid) // コレクションID指定
        .collection("友達").doc(widget.FriendId).collection("勉強").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "name":name,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
    FirebaseFirestore.instance
        .collection('users').doc(widget.FriendId) // コレクションID指定
        .collection("友達").doc(uid).collection("勉強").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "name":name,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
  }
  void date1() {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
    DateFormat outputFormat1 = DateFormat('yyyy年MM月');
    date = outputFormat.format(now);
    Month = outputFormat1.format(now);
    inputData();
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    _loadData();
    _loadData1();
    return id;
  }
  void _loadData()  {
    item = [];
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: date).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          item.add(doc);
          count3 = doc["count"];
          ;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          Monthcount = doc["count"];
          Monthco = 1;
          ;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: "All").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          kaisu = doc["kaisu"];
          Allcount = doc["count"];
          Allco = 1;
          ;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(date).collection("レポート").where("Kamoku", isEqualTo: widget.Kamoku).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          Kamokucount = doc["count"];
          Kamokuco = 1;
          ;});});});
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
  void DateAdd()  {
    if (item.length == 0){
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(date) // ドキュメントID自動生成
          .set({
        "date":date,
        "count":count3,
        "uid":uid,
      });}else{
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(date) // ドキュメントID自動生成
          .update({
        "date":date,
        "count":count3,
        "uid":uid,
      });}
    if (Monthco == 0){
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(Month) // ドキュメントID自動生成
          .set({
        "Month":Month,
        "count":Monthcount,
        "uid":uid,
      });}else{
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(Month) // ドキュメントID自動生成
          .update({
        "Month":Month,
        "count":Monthcount,
        "uid":uid,
      });}
    if (Allco == 0){
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc("All") // ドキュメントID自動生成
          .set({
        "date":"All",
        "kaisu": kaisu ,
        "count":Allcount,
        "uid":uid,});}else{
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc("All") // ドキュメントID自動生成
          .update({
        "date":"All",
        "kaisu": kaisu ,
        "count":Allcount,
        "uid":uid,});;}
    if (Kamokuco == 0){
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(date).collection("レポート").doc(widget.Kamoku) // ドキュメントID自動生成
          .set({"count":Kamokucount,"Kamoku":widget.Kamoku});}else{
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(date).collection("レポート").doc(widget.Kamoku)  // ドキュメントID自動生成
          .update({"count":Kamokucount,"Kamoku":widget.Kamoku});;}
    _loadData();
  }
  Future<void> Add() async {
    var aa = randomString(10);
    await FirebaseFirestore.instance
        .collection('users').doc(uid) // コレクションID指定
        .collection("勉強").doc("All").collection("履歴").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection('users').doc(uid) // コレクションID指定
        .collection("勉強").doc(widget.Kamoku).collection("履歴").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection('users').doc(uid) // コレクションID指定
        .collection("勉強").doc(widget.Kyouzai).collection("履歴").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection('users').doc(uid) // コレクションID指定
        .collection("勉強").doc(date).collection("履歴").doc(aa) // ドキュメントID自動生成
        .set({
      "date":date,
      "kamoku": widget.Kamoku,
      "kyouzai": widget.Kyouzai,
      "messageId": aa,
      "count":time,
      "coment": email,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
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