import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:provider/provider.dart';
import 'dart:convert';
import 'viewgrid.dart';

class FileList extends StatefulWidget {
  final String filePath;

  FileList({
    Key key,
    @required String this.filePath,
  }) : super(key: key);
  @override
  _FolderListState createState() => _FolderListState();
}

class _FolderListState extends State<FileList> {
  List<dynamic> fileList;
  List<Widget> grid;
  TextEditingController _c;
  @override
  void initState() {
    super.initState();
    fileList = new List<dynamic>();
    grid = new List<Widget>();
    _fetch(widget.filePath);
  }

  void _fetch(String _folderPath) async {
    String url;
    if (_folderPath == "") {
      url = "https://blog.nopublisher.dev/v1/folder?username=kim";
    } else {
      url =
          "https://blog.nopublisher.dev/v1/folder?username=kim&folder=$_folderPath";
    }
    var res = await http.get(url);
    String resBody = utf8.decode(res.bodyBytes);
    fileList = jsonDecode(resBody);
    setState(() {
      for (var i = 0; i < fileList.length; ++i) {
        grid.add(
          ViewGrid(
            fileName: fileList[i]["name"],
            folderPath: _folderPath,
          ),
        );
      }
    });
    print(fileList);
  }

  _createFolder(BuildContext context) async {
    _c = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("폴더 이름을 적어"),
            content: TextField(
              controller: _c,
              autofocus: true,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(hintText: "Folder name"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("확인"),
                onPressed: () async {
                  print("send create folder request");
                  String folder = widget.filePath + _c.text;
                  String url =
                      "https://blog.nopublisher.dev/v1/folder?username=kim&folder=$folder";

                  final res = await http.post(url,
                      body: jsonEncode({
                        'name': 'kim',
                        'email': '8859',
                      }),
                      headers: {
                        'Content-Type': "application/json",
                      });
                  setState(() {
                    grid.add(
                      ViewGrid(
                        fileName: _c.text,
                        folderPath: widget.filePath,
                      ),
                    );
                  });
                  print(res);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          primary: true,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 1,
          mainAxisSpacing: 5,
          crossAxisCount: 4,
          children: List.generate(grid.length, (index) => grid[index]),
        ),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        // onOpen: () => print('OPENING DIAL'),
        // onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.create_new_folder),
            backgroundColor: Colors.red,
            label: '폴더 만들기',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _createFolder(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.video_call),
            backgroundColor: Colors.blue,
            label: '동영상 업로드',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.add_photo_alternate),
            backgroundColor: Colors.green,
            label: '이미지 업로드',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_c != null) {
      _c.dispose();
    }
  }
}
