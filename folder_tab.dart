import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:convert';
import 'viewgrid.dart';
import 'file_list.dart';

class FolderTab extends StatefulWidget {
  @override
  _FolderTabState createState() => _FolderTabState();
}

class _FolderTabState extends State<FolderTab> {
  List<dynamic> folderList;
  List<Widget> grid;
  @override
  void initState() {
    super.initState();
    // folderList = new List<dynamic>();
    // grid = new List<Widget>();
    // _fetch();
  }

  // void _fetch() async {
  //   String url = "https://blog.nopublisher.dev/v1/folder?username=kim";
  //   var res = await http.get(url);
  //   String resBody = utf8.decode(res.bodyBytes);
  //   folderList = jsonDecode(resBody);
  //   setState(() {
  //     for (var i = 0; i < folderList.length; ++i) {
  //       grid.add(ViewGrid(fileName: folderList[i]["name"]));
  //     }
  //   });
  //   print(folderList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FileList(
          filePath: "",
        ),
      ),
    );
  }
}
