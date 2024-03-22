//折線
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
class ore extends StatefulWidget{
  @override
  State<ore> createState() => _oreState();
}

class _oreState extends State<ore> {
  var uid = "";
  var date0 = "";
  var date1 = "";
  var date2 = "";
  var date3 = "";
  var date4 = "";
  var date5 = "";
  var date6 = "";
  var Count0 = 0;
  var Count1 = 0;
  var Count2 = 0;
  var Count3 = 0;
  var Count4 = 0;
  var Count5 = 0;
  var Count6 = 0;
  var Count7 = 0;
  var Week0 = "";
  var Week1 = "";
  var Week2 = "";
  var Week3 = "";
  var Week4 = "";
  var Week5 = "";
  var Week6 = "";

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
    // Week ();
  }

  void _loadData()  {
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date0 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count0 = doc["count"];Week0 = doc["曜日"];});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date1 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count1 = doc["count"];Week1 = doc["曜日"];});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date2 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count2 = doc["count"];Week2 = doc["曜日"];;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date3 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count3 = doc["count"];Week3 = doc["曜日"];;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date4 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count4 = doc["count"];Week4 = doc["曜日"];;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date5 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count5 = doc["count"];Week5 = doc["曜日"];;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date6 ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Count6 = doc["count"];Week6 = doc["曜日"];;});});});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(show: false),
                // leftTitles: SideTitles(showTitles: true),
                minX: 1, //x軸最小値
                maxX: 12, //x軸最大値
                minY: 0, //y軸最小値
                maxY: 50, //y軸最大値
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(1, 6),
                      FlSpot(2, 9),
                      FlSpot(3, 15),
                      FlSpot(4, 19),
                      FlSpot(5, 22),
                      FlSpot(6, 26),
                      FlSpot(7, 27),
                      FlSpot(8, 24),
                      FlSpot(9, 18),
                      FlSpot(10, 13),
                      FlSpot(11, 8),
                      FlSpot(12, 6),
                    ],),],

              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

