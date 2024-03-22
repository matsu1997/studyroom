import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart'as simple_animations;
class ChartTestPage extends StatelessWidget {
 // const ChartTestPage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _simpleLine(),
    );
  }

  Widget _simpleLine() {
    var random = Random();

    var data = [
      LinearSales(0, random.nextInt(100)),
      LinearSales(1, random.nextInt(100)),
      LinearSales(2, random.nextInt(100)),
      LinearSales(3, random.nextInt(100)),
    ];

    var seriesList = [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];

    return charts.LineChart(seriesList, animate: true);
  }
}

class LinearSales {
  final int year;
  final int sales;
  LinearSales(this.year, this.sales);
}
// 棒
class Bar extends StatefulWidget {

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  var uid = "";
  var date0 = "";
  var date1 = "";
  var date2 = "";
  var date3 = "";
  var date4 = "";
  var date5 = "";
  var date6 = "";
  var Count0 = 0.0;
  var Count1 = 0.0;
  var Count2 = 0.0;
  var Count3 = 0.0;
  var Count4 =0.0;
  var Count5 = 0.0;
  var Count6 = 0.0;
  var Week0 = "";
  var Week1 = "";
  var Week2 = "";
  var Week3 = "";
  var Week4 = "";
  var Week5 = "";
  var Week6 = "";
  late  List<SubscriberSeries> data = [];
  void initState() {
    super.initState();
    inputData();
  }
  Future<String> inputData() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    String id = user.uid.toString();
    uid = id;
    date();
    return id;
  }
  void date() {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
    date0 = outputFormat.format(now);
    date1 = DateFormat('yyyy年MM月dd日').format(now.add(Duration(days: 1) * -1));
    date2 = DateFormat('yyyy年MM月dd日').format(now.add(Duration(days: 2) * -1));
    date3 = DateFormat('yyyy年MM月dd日').format(now.add(Duration(days: 3) * -1));
    date4 = DateFormat('yyyy年MM月dd日').format(now.add(Duration(days: 4) * -1));
    date5 = DateFormat('yyyy年MM月dd日').format(now.add(Duration(days: 5) * -1));
    date6 = DateFormat('yyyy年MM月dd日').format(now.add(Duration(days: 6) * -1));
    _loadData();
    Week ();
  }

  void _loadData()  {
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date0 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count0 = doc["count"]/60;Week0 = doc["曜日"];Week ();});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date1 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count1 = doc["count"]/60;Week1 = doc["曜日"];Week ();});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date2 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count2 = doc["count"]/60;Week2 = doc["曜日"];Week ();});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date3 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count3 = doc["count"]/60;Week3 = doc["曜日"];Week ();});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date4 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count4 = doc["count"]/60;Week4 = doc["曜日"];Week ();});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date5 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count5 = doc["count"]/60;Week5 = doc["曜日"];Week ();});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date6 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count6 = doc["count"]/60;Week6 = doc["曜日"];Week ();});});});
  }
  void Week (){
    data = [
      SubscriberSeries(
        year:  Week6,
        subscribers: Count6.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      SubscriberSeries(
        year:  Week5,
        subscribers: Count5.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.greenAccent),
      ),
      SubscriberSeries(
        year:  Week4,
        subscribers: Count4.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.purple),
      ),
      SubscriberSeries(
        year:  Week3,
        subscribers: Count3.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.orangeAccent),
      ),
      SubscriberSeries(
        year:  Week2,
        subscribers: Count2.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.redAccent),
      ),
      SubscriberSeries(
        year:  Week1,
        subscribers: Count1.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.brown),
      ),
      SubscriberSeries(
        year: Week0,
        subscribers: Count0.toInt(),
        barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:SubscriberChart(data: data)
      ),
    );
  }
}

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;
  SubscriberSeries({
    required this.year,
    required this.subscribers,
    required this.barColor
  });
}

class SubscriberChart extends StatelessWidget {
  final List<SubscriberSeries> data;
  SubscriberChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series
    = [
      charts.Series(
        id: "“Subscribers”",
        data: data,
        domainFn: (SubscriberSeries series, _) =>
        series.year,
        measureFn: (SubscriberSeries series, _) =>
        series.subscribers,
        colorFn: (SubscriberSeries series, _) =>
        series.barColor,
      )
    ];
    return Scaffold(
      body: Center(
        child: Container(
         // height: 400,
          padding: EdgeInsets.all(0),
          child: Card(
            child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 2),
                    child: Text("1週間の勉強量(分)",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,),)
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 0, right: 0),
                          child: charts.BarChart(series, animate: true,)
                      )
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}