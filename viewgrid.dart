import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'folder_tab.dart';
import 'file_list.dart';

class ViewGrid extends StatefulWidget {
  final String fileName;
  final String folderPath;
  final Uint8List image;

  ViewGrid({
    Key key,
    @required this.fileName,
    @required this.folderPath,
    this.image,
  }) : super(key: key);

  @override
  _ViewGridState createState() => _ViewGridState();
}

class _ViewGridState extends State<ViewGrid> {
  // TextEditingController _c;

  // _showInputText() async {
  //   await showDialog(
  //     context: context,
  //     child:
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    String path = widget.folderPath + widget.fileName + "/";
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: Text("folder"),
            ),
            body: FileList(filePath: path),
          ),
        ),
      ),
      child: Card(
        child: Center(
          child: widget.image == null
              ? Text(widget.fileName)
              : Image.memory(widget.image), //Text(widget.fileName),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _c.dispose();
  }
}
