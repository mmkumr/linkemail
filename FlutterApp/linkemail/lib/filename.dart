// @dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:linkemail/filedetails.dart';
import 'package:linkemail/widgets/mydrawer.dart';
import 'package:share/share.dart';

class FileName extends StatefulWidget {
  FileName({Key key}) : super(key: key);

  @override
  _FileNameState createState() => _FileNameState();
}

class _FileNameState extends State<FileName> {
  DatabaseReference _firebase = FirebaseDatabase.instance.reference();
  Map<dynamic, dynamic> map;
  List items = [];
  List uid = [];
  @override
  Widget build(BuildContext context) {
    _firebase.once().then((DataSnapshot ds) {
      setState(() {
        map = ds.value;
      });
      if (map != null) {
        map.forEach((key, value) {
          print(key);
          setState(() {
            items.add(value["filename"]);
            uid.add(key);
          });
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Email File Link"),
      ),
      drawer: Mydrawer(),
      body: map == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: map.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FileDetails(uid[index]),
                          ),
                        );
                      },
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              items[index],
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          onPressed: () {
                            Share.share(
                                "download.businessteam.in/?f=" + uid[index]);
                          },
                          color: Colors.orangeAccent,
                          child: Text("Share link",
                              style: TextStyle(color: Colors.white)),
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => FileName(),
                              ),
                            );
                            _firebase.child(uid[index]).remove();
                          },
                          color: Colors.orangeAccent,
                          child: Text("Delete",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                );
              }),
    );
  }
}
