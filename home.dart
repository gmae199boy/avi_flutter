import 'package:flutter/material.dart';
import './video_add_tab.dart';
import './folder_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Create Folder"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('ffmpeg test app'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black, //LinearGradient
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex, //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Folder'),
            icon: Icon(Icons.folder),
          ),
          BottomNavigationBarItem(
            title: Text('Video'),
            icon: Icon(Icons.video_call),
          ),
          BottomNavigationBarItem(
            title: Text('Picture'),
            icon: Icon(Icons.picture_in_picture_alt),
          ),
          BottomNavigationBarItem(
            title: Text('My'),
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  List _widgetOptions = [
    FolderTab(),
    VideoAddTab(),
    Text(
      'Places',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    Text(
      'News',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
  ];
}
