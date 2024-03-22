
import 'package:flutter/material.dart';

class Record extends StatefulWidget {
  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
          //backgroundColor: Colors.grey[100],
            title: Text('記録',style: TextStyle(color:Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: []
        ),
        body: Container(
        )
    );
  }
}