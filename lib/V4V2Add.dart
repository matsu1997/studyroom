
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class V4V2Add extends StatefulWidget {
  @override
  V4V2Add(this.name, this.Id, this.uid);

  String name;
  String Id;
  String uid;

  static Future<String?> select_icon(BuildContext context) async {
    String SELECT_ICON = "アイコンを選択";
    List<String> SELECT_ICON_OPTIONS = ["写真から選択", "写真を撮影"];
    int GALLERY = 0;
    int CAMERA = 1;

    var _select_type = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(SELECT_ICON),
            children: SELECT_ICON_OPTIONS.asMap().entries.map((e) {
              return SimpleDialogOption(
                child: ListTile(
                  title: Text(e.value),
                ),
                onPressed: () => Navigator.of(context).pop(e.key),
              );
            }).toList(),
          );
        });

    final picker = ImagePicker();
    var _img_src;

    if (_select_type == null) {
      return null;
    }
    //カメラで撮影
    else if (_select_type == CAMERA) {
      _img_src = ImageSource.camera;
    }
    //ギャラリーから選択
    else if (_select_type == GALLERY) {
      _img_src = ImageSource.gallery;
    }

    final pickedFile = await picker.getImage(source: _img_src);

    if (pickedFile == null) {
      return null;
    } else {
      return pickedFile.path;
    }
  }

  @override
  State<V4V2Add> createState() => _V4V2AddState();
}

class _V4V2AddState extends State<V4V2Add> {
  File? get nil => null;

  void initState() {
    super.initState();
  }
  String imgPathUse="";
  File? _image;
  var _controller = TextEditingController();
  var ID = "";
  String email = '';
  bool _B = false;
  final imagePicker = ImagePicker();

  Future getImageFromCamera() async {
    _B = true;
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  PickedFile? pickedFile;

  Future getImageFromGarally() async {
    _B = true;
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile!.path);
      }
    });
  }

  Future<void> uploadFile(String sourcePath, String uploadFileName) async {
    showProgressDialog();
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images"); //保存するフォルダ
    io.File file = io.File(sourcePath);
    UploadTask task = ref.child(uploadFileName).putFile(file);

    try {
      var snapshot = await task;
    } catch (FirebaseException) {
      //エラー処理
    }
    //addFilePath(uid, pickedFile!.path);
    getImgs(ID);
    // addFilePath(widget.uid, pickedFile!.path);
    // Navigator.of(context).pop();
  }

  Future<void> addFilePath(String userId, String localPath) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users
        .doc(userId)
        .collection("写真")
        .doc(widget.Id)
        .collection("写真")
        .doc(ID)
        .set({
      "text": email,
      "messageId": ID,
      'ImgId': imgPathUse,
    }, SetOptions(merge: true));
    _controller.clear();
    _image = nil;
    imgPathUse = "";
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
  }
  void getImgs(String imgPathRemote) async{
    if ((imgPathRemote != "") && (imgPathRemote != null)) {
      try {
        imgPathUse = await FirebaseStorage.instance.ref().
        child("images").child(imgPathRemote).getDownloadURL();
        addFilePath(widget.uid, pickedFile!.path);
      }
      catch (FirebaseException) {}} else{}}
  String randomString(int length) {
    const _randomChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("暗記ノート",style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        // body: Center(
        //     child: _image == null
        //         ? Text(
        //       '写真を選択してください',
        //       style: Theme.of(context).textTheme.headline4,
        //     )
        //         : Image.file(_image!)),
        // floatingActionButton:
        // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //   FloatingActionButton(
        //       onPressed:(){ ID = randomString(20);
        //         uploadFile(pickedFile!.path,ID);}, child: Icon(Icons.photo_camera)),
        //   FloatingActionButton(
        //       onPressed: getImageFromGarally, child: Icon(Icons.photo_album))
        // ])
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: _image == null ?
                    Text(
                      '写真を１枚選択してください',
                      // style: Theme.of(context).textTheme.headline4,
                    )
                        : Image.file(_image!)),),
              Container(
                  margin: EdgeInsets.only(top:20,bottom: 20),
                  child:
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    FloatingActionButton(
                        onPressed: getImageFromCamera, child: Icon(Icons.photo_camera)),
                    FloatingActionButton(
                        onPressed: getImageFromGarally, child: Icon(Icons.photo_album))
                  ])),
              Container(
                margin: EdgeInsets.only(top:20,bottom: 20),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'この写真のコメント'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),),
              Container(
                margin: EdgeInsets.only(top:20,bottom: 20),
                child: ElevatedButton(
                  child: Text('追加',style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: !_B ? null:()  {
                    ID = randomString(20);
                    uploadFile(pickedFile!.path,ID);
                    setState(() { _B  = false;FocusScope.of(context).unfocus(); });

                  },
                ),)
            ])));
  }
  void showProgressDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });}
}