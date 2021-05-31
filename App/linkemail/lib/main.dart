// @dart=2.9
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_storage/firebase_storage.dart';
import 'package:linkemail/widgets/mydrawer.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Email File Link'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference _firebase = FirebaseDatabase.instance.reference();
  File file;
  bool selected = false;
  bool loading = false;
  String _uploadedFileURL;
  final link = TextEditingController();
  String uid = "";

  @override
  Widget build(BuildContext context) {
    link.text = "download.businessteam.in/?f=" + uid;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(
        title: Text("Email File Link"),
      ),
      body: Center(
        child: loading == true
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        FilePickerResult result =
                            (await FilePicker.platform.pickFiles());

                        // ignore: unnecessary_null_comparison
                        if (result != null) {
                          // ignore: unused_local_variable
                          setState(() {
                            file = File(result.files.single.path);
                            selected = true;
                          });
                          print(file);
                        } else {
                          // User canceled the picker
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: selected,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            uid = Uuid().v1().toString();
                            loading = true;
                          });
                          StorageReference storageReference = FirebaseStorage
                              .instance
                              .ref()
                              .child('${Path.basename(file.path)}');
                          StorageUploadTask uploadTask =
                              storageReference.putFile(file);
                          await uploadTask.onComplete;
                          print('File Uploaded');
                          storageReference.getDownloadURL().then((fileURL) {
                            setState(() {
                              _uploadedFileURL = fileURL;
                              _firebase.child("/${uid}").update(
                                {"url": _uploadedFileURL},
                              );
                              _firebase.child("/${uid}").update(
                                {
                                  "filename": file.path
                                      .substring(file.path.lastIndexOf("/") + 1)
                                },
                              );
                              loading = false;
                            });
                          });
                          var alert = new AlertDialog(
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  file.delete();
                                  setState(() {
                                    selected = false;
                                  });
                                },
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: Colors.orangeAccent),
                                ),
                              ),
                            ],
                            title: Text("Copy the below link"),
                            content: TextField(
                              controller: link,
                              readOnly: true,
                            ),
                          );
                          link.text = uid;
                          showDialog(context: context, builder: (_) => alert);
                        },
                        color: Colors.orangeAccent,
                        height: 50,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Upload File",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
