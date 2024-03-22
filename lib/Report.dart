import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:studyroom/remaind.dart';
import 'CustomShapPainter.dart';
import 'LineChart.dart';

class Report extends StatefulWidget {
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  var item = [];
  var uid = "";
  var Todaycount= 0.0;
  var Monthcount= 0.0;
  var Monthcount1= 0.0;
  var Monthcount2= 0.0;
  var Monthcount3=0.0;
  var Monthcount4=0.0;
  var Monthcount5= 0.0;
  var Monthcount6= 0.0;
  var Monthcount7=0.0;
  var Monthcount8=0.0;
  var Monthcount9= 0.0;
  var Monthcount10=0.0;
  var Monthcount11=0.0;
  var Monthcount12=0.0;
  var Monthco= 0;
  var Monthco1= 0;
  var Monthco2= 0;
  var Monthco3= 0;
  var Monthco4= 0;
  var Monthco5= 0;
  var Monthco6= 0;
  var Monthco7= 0;
  var Monthco8= 0;
  var Monthco9= 0;
  var Monthco10= 0;
  var Monthco11= 0;
  var kaisu = 0;
  var Allcount = 0;
  var  sum = 0.0;
  var  Circleco = 0;
  var Month = "";
  var Month1 = "";
  var Month2 = "";
  var Month3 = "";
  var Month4 = "";
  var Month5 = "";
  var Month6 = "";
  var Month7 = "";
  var Month8 = "";
  var Month9 = "";
  var Month10 = "";
  var Month11 = "";
 get key => null;
var date = "";
  List<EChartPieBean>  dataList = [EChartPieBean(title: "", number: 0, color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0,).withOpacity(1.0))];
  void initState() {
    super.initState();
    date1();
  }
  void date1() {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
    DateFormat outputFormat1 = DateFormat('yyyy年MM月');
    date = outputFormat.format(now);
    Month = outputFormat1.format(now);
    DateTime mon = DateTime(now.year, now.month, 1);//8/1
    DateTime result = mon.add(Duration(days: 1) * -1);//7/31
    Month1 = outputFormat1.format(result);
     mon = DateTime(result.year, now.month, 1);//7/1
     result = result.add(Duration(days: 1) * -1);//6/31
    Month2 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month3 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month4 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month5 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month6 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month7 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month8 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month9 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month10 = outputFormat1.format(result);
    mon = DateTime(result.year, now.month, 1);
    result = result.add(Duration(days: 1) * -1);
    Month11 = outputFormat1.format(result);
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
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date" , isEqualTo: date ).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {item.add(doc);Todaycount = doc["count"]/60;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco  = doc["月"];Monthcount = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month1).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco1  = doc["月"];Monthcount1 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month2).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco2  = doc["月"];Monthcount2 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month3).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco3  = doc["月"];Monthcount3 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month4).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco4  = doc["月"];Monthcount4 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month5).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco5  = doc["月"];Monthcount5 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month6).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco6  = doc["月"];Monthcount6 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month7).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco7  = doc["月"];Monthcount7 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month8).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco8  = doc["月"];Monthcount8 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month9).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco9  = doc["月"];Monthcount9 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month10).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco10  = doc["月"];Monthcount10 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where('date', isEqualTo: Month11).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {Monthco11  = doc["月"];Monthcount11 = doc["count"]/ 60;;});});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").where("date", isEqualTo: "All").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
          kaisu = doc["kaisu"];
          Allcount = doc["count"];
          sum = Allcount / 60 / kaisu;
       ;});});
    FirebaseFirestore.instance.collection('users').doc(uid).collection("勉強").doc(date).collection("レポート").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          if (Circleco == 0){dataList = [];}
          Circleco = 1;
          dataList.add(EChartPieBean(title: doc["Kamoku"], number: doc["count"], color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0,).withOpacity(1.0)));
          });});});
    setState(() {});
  }
  List<EChartPieBean> defaultList = [
    EChartPieBean(title: "生活费", number: 200, color: Colors.lightBlueAccent),
    EChartPieBean(title: "游玩费", number: 200, color: Colors.deepOrangeAccent),
    EChartPieBean(title: "交通费", number: 400, color: Colors.green),
    EChartPieBean(title: "贷款费", number: 300, color: Colors.amber),
    EChartPieBean(title: "电话费", number: 200, color: Colors.orange),
  ];

  Widget _simpleLine() {
    var random = Random();
    var data = [
      LinearSales(Monthco11, Monthcount11.toInt()),
      LinearSales(Monthco10, Monthcount10.toInt()),
      LinearSales(Monthco9, Monthcount9.toInt()),
      LinearSales(Monthco8, Monthcount8.toInt()),
      LinearSales(Monthco7, Monthcount7.toInt()),
      LinearSales(Monthco6, Monthcount6.toInt()),
      LinearSales(Monthco5, Monthcount5.toInt()),
      LinearSales(Monthco4, Monthcount4.toInt()),
      LinearSales(Monthco3, Monthcount3.toInt()),
      LinearSales(Monthco2, Monthcount2.toInt()),
      LinearSales(Monthco1, Monthcount1.toInt()),
      LinearSales(Monthco, Monthcount.toInt()),
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
    return charts.LineChart(seriesList,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          // 圆点大小
          radiusPx: 5.0,
          stacked: false,
          // 线的宽度
          strokeWidthPx: 2.0,
          // 是否显示线
          includeLine: true,
          // 是否显示圆点
          includePoints: true,
          // 是否显示包含区域
          includeArea: true,
          // 区域颜色透明度 0.0-1.0
          areaOpacity: 0.2,
        ));
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("レポート",style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
          onPressed: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => remaind()),);},
      child: Text(' 復習/履歴 ',
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),)
        ],
      ),
      body: Center(
        // height: 10000.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Container(
                  // width: double.infinity,
                  // height: double.infinity,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  // child:FittedBox(
                  //   fit: BoxFit.contain,
                  child:Bar()
                  // ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10, left: 10, right: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Container(
                          //width: double.infinity,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          // child:FittedBox(
                          //   fit: BoxFit.contain,
                          child:  Column(
                            children: [
                              Container(
                                child: Text("1ヶ月の勉強量(分)", style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ), textAlign: TextAlign.center,),
                              ),Expanded(child: _simpleLine(),)
                            ],)
                          // ),
                          ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.center,
                                child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Text("一回あたりの平均時間", style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ), textAlign: TextAlign.center,),
                                        ),
                                        Container(
                                            child: Text(sum.toInt().toString() + "分", style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32,
                                          ), textAlign: TextAlign.center,
                                        ))],)
                                ),),),),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Text("今日の勉強量", style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ), textAlign: TextAlign.center,),
                                        ),
                                        Container(
                                            child: Text(Todaycount.toInt().toString() + "分",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32,
                                          ),
                                          textAlign: TextAlign.center,
                                        ))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  // child:FittedBox(
                  //fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "今日の勉強割合",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(child: EChatWidget(dataList: dataList)),
                      Container(height: 10,),
                    ],
                  )
                  // Text("aa",
                  //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32,), textAlign: TextAlign.center,
                  // )
                  //,)
                  ,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
