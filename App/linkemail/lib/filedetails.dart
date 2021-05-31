// @dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:linkemail/widgets/mydrawer.dart';

class FileDetails extends StatefulWidget {
  String uid;
  FileDetails(this.uid);

  @override
  _FileDetailsState createState() => _FileDetailsState();
}

class _FileDetailsState extends State<FileDetails> {
  @override
  DatabaseReference _firebase = FirebaseDatabase.instance.reference();
  Map<dynamic, dynamic> map;
  List items = [];
  String filename;
  @override
  Widget build(BuildContext context) {
    _firebase.child(widget.uid).once().then((DataSnapshot ds) {
      setState(() {
        filename = ds.value["filename"];
        map = ds.value["emails"];
      });
      if (map != null) {
        map.forEach((key, value) {
          print(key);
          setState(() {
            items.add(value);
          });
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(filename),
      ),
      drawer: Mydrawer(),
      body: map == null
          ? Center(
              child: Container(
                child: Text(
                  "No one has viewed this file",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )
          : ListView.builder(
              itemCount: map.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Email: " + items[index]["email"],
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                        Text(
                          "name: " + items[index]["name"],
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                        Divider(
                          color: Colors.orangeAccent,
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
