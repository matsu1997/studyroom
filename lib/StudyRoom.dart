import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';
import 'package:studyroom/main.dart';
import 'package:studyroom/remaindStudy.dart';
import 'package:studyroom/round-button.dart';
import 'countdown-page.dart';
import 'fab_animation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class StudyRoom extends StatefulWidget {
  @override
  State<StudyRoom> createState() => _StudyRoomState();

  StudyRoom(this.Kamoku, this.Kyouzai, this.messageId, this.uid,this.int,this.GrupId,this.FriendId);

  String Kamoku;
  String Kyouzai;
  String messageId;
  String uid;
  String int;
  String GrupId;
  String FriendId;
}enum Menu { Kamoku,Kyouzai,date,All}

class _StudyRoomState extends State<StudyRoom> {
  late Timer _timer;
  late DateTime _time;
  var count = 0;
  var co = 0;
  var date = "";
  bool stop = true;
  bool countdown = true;
  @override
  void initState() {
    _time = DateTime.utc(0, 0, 0);
    super.initState();
    date1();
    main();
  }

  Duration timerDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:  Text(widget.Kyouzai,style: TextStyle(color:Colors.black),),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton(
                onSelected: popupMenuSelected,
                icon:Icon(Icons.lightbulb_outline_sharp),
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Menu>>[
                   PopupMenuItem( child:  ListTile( leading:Icon(Icons.star),
                      title:Text(widget.Kamoku + "の履歴を見る")), value: Menu.Kamoku,),
                   PopupMenuItem( child:ListTile( leading:Icon(Icons.star),
                      title:Text(widget.Kyouzai + "の履歴を見る")), value: Menu.Kyouzai),
                  PopupMenuItem( child:ListTile( leading:Icon(Icons.star),
                      title:Text("今日の履歴を見る")), value: Menu.date),
                  PopupMenuItem( child: ListTile( leading:Icon(Icons.star),
                      title:Text("全ての履歴を見る")), value: Menu.All,),
                ],
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("ストップウォッチ",style: TextStyle(fontSize: 11,color:Colors.black),),),
                Tab(child: Text("タイマー",style: TextStyle(fontSize: 11,color:Colors.black),),),
                Tab(child: Text("休憩",style: TextStyle(fontSize: 11,color:Colors.black),),),],
            ),
          ),
          body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Text(widget.Kamoku,style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Text(widget.Kyouzai,style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold, fontSize: 20),),
                ),
          Expanded(
          child:TabBarView(
            children: [
              Stop(widget.Kamoku, widget.Kyouzai,
                  widget.messageId, widget.uid,widget.int,widget.GrupId,widget.FriendId),
              CountdownPage(widget.Kamoku, widget.Kyouzai,
                  widget.messageId, widget.uid,widget.int,widget.GrupId,widget.FriendId),
              Rest()
            ],
          ),
        ),]
          )
        ),
      ),
    );
  }

  void popupMenuSelected(Menu selectedMenu){
    switch(selectedMenu) {
      case Menu.Kamoku:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => remaindStudy(widget.Kamoku)));
        break;
      case Menu.Kyouzai:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => remaindStudy(widget.Kyouzai)));
        break;
      case Menu.date:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => remaindStudy(date)));
        break;
      case Menu.All:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => remaindStudy("All")));
        break;
      default:
        break;
    }
  }
  void date1() {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
    date = outputFormat.format(now);
  }
}

class Stop extends StatefulWidget {
  @override
  Stop(this.Kamoku, this.Kyouzai,this.messageId, this.uid,this.int,this.GrupId,this.FriendId);

  String Kamoku;
  String Kyouzai;
  String messageId;
  String uid;
  String int;
  String GrupId;
  String FriendId;
  State<Stop> createState() => _StopState();
}

class _StopState extends State<Stop>with WidgetsBindingObserver {
  late Timer _timer;
  late DateTime _time;
  var count = 0;
  var count2 = 0;
  var count3 = 0;
  var kaisu = 0;
  var Monthcount= 0;
  var Allcount= 0;
  var Kamokucount = 0;
  var Month = "";
  var MonthInt = 0;
  var Monthco = 0;
  var Allco = 0;
  var Kamokuco = 0;
  var co = 0;
  var start = 0;
  var uid = "";
  var time = "";
  var name = "";
  String email = '';
  String date = "";
  String week = "";
  var item = [];
  late DateTime  now;
  late DateTime  now1;
  var dif = 0;
  var _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _time = DateTime.utc(0, 0, 0);
    super.initState();
   date1();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stete = $state");
    switch (state) {
      case AppLifecycleState.inactive:
      break;
      case AppLifecycleState.paused:;main();
      break;
      case AppLifecycleState.resumed:main1();
      break;
      case AppLifecycleState.detached:
      break;
    }
  }
  void main() {
    now = DateTime.now();
    _timer.cancel();
    print(now); //2022-03-14 05:51:05.176
  }
  void main1() {
    if (start == 1){
    _timer = Timer.periodic(
      Duration(seconds: 1), // 1秒毎に定期実行
          (Timer timer) {
        setState(() {
          _time = _time.add(Duration(seconds: 1));
          count = count + 1;
        });
      },
    );
    now1 = DateTime.now();
    print(now); //2022-03-14 05:51:05.176
    dif = now1.difference(now).inSeconds;
    print(dif); //-216
    _time = _time.add(Duration(seconds: dif));
    count = count + dif;
  }}

  @override
  Widget build(BuildContext context) {
    // setState() の度に実行される
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
      Expanded(
        child: Stack(children: <Widget>[
          new Center(
              child: Container(child: CustomPaint(painter: _MyPainter()))),
          new Center(
            child: Text(DateFormat.Hms().format(_time),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                )),
          )
        ]),
      ),
      Container(
        margin: new EdgeInsets.only(
          bottom: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                onPressed:() {
                  // Startボタンタップ時の処理
                  if (co == 0) {
                    start = 1;
                    _timer = Timer.periodic(
                      Duration(seconds: 1), // 1秒毎に定期実行
                          (Timer timer) {
                        setState(() {
                          _time = _time.add(Duration(seconds: 1));
                          count = count + 1;
                        });
                      },
                    );
                    co =  1;
                  }else{}

                },
                child: Icon(
                  Icons.play_arrow,
                )),
            FloatingActionButton(
                onPressed: () {
                   time = DateFormat.Hms().format(_time);
                   count2 = count;
                   count3 = count3 + count2;
                   Monthcount =  Monthcount + count2;
                   Allcount =  Allcount + count2;
                   Kamokucount = Kamokucount + count2;
                   kaisu = kaisu + 1;
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
                   DateAdd();
                  showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: Text("履歴を残しますか？" ,textAlign: TextAlign.center,),
                            content: Text(time,textAlign: TextAlign.center,),
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
                               ],)],));
                  //Stopボタンタップ時の処理
                  if (_timer != null && _timer.isActive) _timer.cancel();
                  count = 0;
                  _time = DateTime.utc(0, 0, 0);
                  setState(() {
                    start = 0;
                    co = 0;
                  });
                },
                child: Icon(Icons.pause)),
          ],
        ),
      )
    ]));
  }
  // Future<void> _requestPermissions() async {
  //   await _flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
  void date1() {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
    DateFormat outputFormat1 = DateFormat('yyyy年MM月');
    DateFormat outputFormat2 = DateFormat('MM月');
    date = outputFormat.format(now);
    Month = outputFormat1.format(now);
    var Mon = outputFormat2.format(now);
    print(Mon);
    print("Mon");
    switch (Mon) {
      case "01月" :MonthInt = 1;
      break;
      case "02月" :MonthInt = 2;
      break;
      case "03月" :MonthInt = 3;
      break;
      case "04月" :MonthInt = 4;
      break;
      case "05月" :MonthInt = 5;
      break;
      case "06月" :MonthInt = 6;
      break;
      case "07月" :MonthInt = 7;
      break;
      case "08月" :MonthInt = 8;
      break;
      case "09月" :MonthInt = 9;
      break;
      case "10月" :MonthInt = 10;
      break;
      case "11月" :MonthInt = 11;
      break;
      case "12月" :MonthInt = 12;
    }
    var aa = DateTime.now().weekday;
    switch (aa) {
      case 1 : week = "月";
        break;
      case 2 :week = "火";
        break;
      case 3 :week = "水";
        break;
      case 4 :week = "木";
        break;
      case 5 :week = "金";
        break;
      case 6 :week = "土";
        break;
      case 7 :week = "日";
        break;
    }
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
      "count":count2,
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
      "count":count2,
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
      "count":count2,
      "coment": email,
      "name":name,
      "uid":uid,
      "createdAt": Timestamp.now(),
    });
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
        "count":count2,
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
        "count":count2,
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
        "count":count2,
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
        "count":count2,
        "coment": email,
        "uid":uid,
        "createdAt": Timestamp.now(),
      });
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
         "曜日":week
      });}else{
    FirebaseFirestore.instance
        .collection('users').doc(uid) // コレクションID指定
        .collection("勉強").doc(date) // ドキュメントID自動生成
        .update({
      "date":date,
      "count":count3,
      "uid":uid,
      "曜日":week
    });}
    if (Monthco == 0){
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(Month) // ドキュメントID自動生成
          .set({
        "date":Month,
        "count":Monthcount,
        "uid":uid,
        "月": MonthInt
      });}else{
      FirebaseFirestore.instance
          .collection('users').doc(uid) // コレクションID指定
          .collection("勉強").doc(Month) // ドキュメントID自動生成
          .update({
        "date":Month,
        "count":Monthcount,
        "uid":uid,
        "月": MonthInt
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

class _MyPainter extends CustomPainter {
  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(const Offset(0, 0), 150, stroke);
  }




}

class Rest extends StatefulWidget {
  @override
  _RestState createState() => _RestState();
}

class _RestState extends State<Rest>
    with TickerProviderStateMixin , WidgetsBindingObserver {
  late AnimationController controller;
  bool isPlaying = false;
  var  second = 0;
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
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 300)
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

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  double progress = 1.0;
  var time = 0;
  var co = 0;
  var time0 = "";
  var name = "";
  void notify() {
    time = controller.duration!.inSeconds;
    time0 = '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}';
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();}}


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
                    valueColor: AlwaysStoppedAnimation(Colors.green,),
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
                      style: TextStyle( fontSize: 60,
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
                    color: Colors.green,
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),

                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      final flnp = FlutterLocalNotificationsPlugin();
                      flnp.cancel(0);
                      isPlaying = false;
                    });
                  },
                  child: RoundButton(
                    color: Colors.green,
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
    ).then((_) => flnp.zonedSchedule(0, '休憩終了です！', '',
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
    ).then((_) => flnp.zonedSchedule(0, '休憩終了です！', '',
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


}