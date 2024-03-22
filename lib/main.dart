import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/remaind.dart';
import 'Report.dart';
import 'V1.dart';
import 'V2.dart';
import 'V3.dart';
import 'V4.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //ここ！
  await Firebase.initializeApp(); //ここ！
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomNav',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

}
// @override



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // ページインデックス保存用
  int _screen = 0;
  // 表示する Widget の一覧
  static List<Widget> _pageList = [
    V1("0","",""),
    V4(),
    Report(),
    V2(),
  ];
  // ページ下部に並べるナビゲーションメニューの一覧
  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.border_color),
        label: '勉強部屋',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark_border),
        label: '暗記',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.access_alarm),
        label: 'レポート',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: '友達',
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_screen],
      // ページ下部のナビゲーションメニュー
      bottomNavigationBar: BottomNavigationBar(
        // 現在のページインデックス
        currentIndex: _screen,
        type: BottomNavigationBarType.fixed,
        // onTapでナビゲーションメニューがタップされた時の処理を定義
        onTap: (index) {
          setState(() {
            // ページインデックスを更新
            _screen = index;
          });
        },
        // 定義済のナビゲーションメニューのアイテムリスト
        items: myBottomNavBarItems(),
      ),

    );

  }

}

