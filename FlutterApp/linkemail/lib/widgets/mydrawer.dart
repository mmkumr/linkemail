import 'package:flutter/material.dart';
import 'package:linkemail/filename.dart';
import 'package:linkemail/main.dart';

class Mydrawer extends StatefulWidget {
  Mydrawer({Key? key}) : super(key: key);

  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.file_upload,
                  size: 40,
                  color: Colors.orangeAccent,
                ),
                title: Text(
                  "Upload File",
                  style: TextStyle(fontSize: 20, color: Colors.orangeAccent),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.orange,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FileName()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.file_upload,
                  size: 40,
                  color: Colors.orangeAccent,
                ),
                title: Text(
                  "Uploaded File details",
                  style: TextStyle(fontSize: 20, color: Colors.orangeAccent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
