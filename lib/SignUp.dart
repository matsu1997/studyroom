import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyroom/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../V1.dart';

void main() async {
  // 初期化処理を追加
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

/* --- 省略 --- */

// ログイン画面用Widget
class SignUp extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  // メッセージ表示用
  String infoText = '';

  // 入力したメールアドレス・パスワード
  String email = '';
  String name = '';
  String password = '';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力
              TextFormField(
                decoration: InputDecoration(labelText: 'ユーザーの名前'),
                onChanged: (String value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              // パスワード入力
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                // メッセージ表示
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("プライバシーポリシー"),
                  onPressed: () async {
                    final url = "https://note.com/nao19941/n/n733f411bc958";
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    onPrimary: Colors.blue,
                    //ボタンの背景色
                  ),
                ),),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("利用規約"),
                  onPressed: () async {
                    final url = "https://note.com/nao19941/n/n537db72e26f2";
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    onPrimary: Colors.blue,
                  ),

                ),),
              Container(
                width: double.infinity,
                // ユーザー登録ボタン
                child: ElevatedButton(
                    child: Text('上記２つに同意してユーザー登録'),
                    onPressed: () async {
                       if (email != "" || name != "" || password != ""){
                      try {
                        // メール/パスワードでユーザー登録
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        await auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                       // if (email != "" || name != "" || password != ""){
                        add();
                      //}
                        // ユーザー登録に成功した場合// チャット画面に遷移＋ログイン画面を破棄
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }),);
                      } catch (e) {
                        // ユーザー登録に失敗した場合
                        setState(() {
                          infoText = "登録に失敗しました：${e.toString()}";
                        });}
                    }else{
    setState(() {
    infoText = "登録に失敗しました";
    });
                       }}
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                // ログイン登録ボタン
                child: OutlinedButton(
                  child: Text('ログイン'),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ログインに成功した場合
                      // チャット画面に遷移＋ログイン画面を破棄
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return MyApp();
                        }),
                      );
                    } catch (e) {
                      /* --- 省略 --- */
                    }
                  },
                ),)
            ],
          ),
        ),
      ),
    );
  }
  Future<void> add() async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      await FirebaseFirestore.instance
          .collection('users').doc(user?.uid)// コレクションID指定
          .set({
        "email" : email,
        "uid":user?.uid,
        "name":name,
        "createdAt": Timestamp.now(),
      });
    });}
}

/* --- 省略 --- */
