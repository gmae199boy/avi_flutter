import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_compress/video_compress.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:file_picker/file_picker.dart';
import 'viewgrid.dart';

class VideoAddTab extends StatefulWidget {
  @override
  _VideoAddTabState createState() => _VideoAddTabState();
}

class _VideoAddTabState extends State<VideoAddTab> {
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
  // List<Uint8List> _thumbnailImage;
  List<File> videoFiles;
  List<Widget> grid;
  List<Uint8List> videoThumbnail;
  bool _isLoading;

  @override
  void initState() {
    videoFiles = new List<File>();
    videoThumbnail = new List<Uint8List>();
    grid = new List<Widget>();
    grid.add(
      Container(
        child: FloatingActionButton(
          onPressed: _getVideo,
          tooltip: 'Pick Video',
          child: Icon(Icons.video_call),
        ),
      ),
    );
    grid.add(
      Container(
        child: FloatingActionButton(
          onPressed: _getVideo,
          tooltip: 'Send Video',
          child: Icon(Icons.send),
        ),
      ),
    );
    _isLoading = false;
    super.initState();
  }

  Future<int> _startVideoConvert() async {
    int _execId = await _flutterFFmpeg.executeAsync("",
        (int executionId, int returnCode) {
      print(
          "FFmpeg process for executionId $executionId exited with rc $returnCode");
    });
    print("Async FFmpeg process started with executionId $_execId.");
    return _execId;
  }

  Future _getVideo() async {
    setState(() => _isLoading = true);
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.video);
    if (result != null) {
      // video_thumbnail
      for (var i = 0; i < result.paths.length; ++i) {
        videoThumbnail.add(await VideoThumbnail.thumbnailData(
          video: result.paths[i],
          imageFormat: ImageFormat.PNG,
          // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          maxWidth: 128,
          quality: 50,
        ));
      }
      // video_compress
      // for (var i = 0; i < result.paths.length; ++i) {
      //   videoThumbnail.add(await VideoCompress.getByteThumbnail(result.paths[i],
      //       quality: 50, // default(100)
      //       position: -1 // default(-1)
      //       ));
      // }
      setState(() {
        for (var i = 0; i < result.paths.length; ++i) {
          videoFiles.add(File(result.paths[i]));
          grid.add(ViewGrid(
            fileName: basename(videoFiles[i].path),
            folderPath: "",
            image: videoThumbnail[i],
          ));
        }
        _isLoading = false;
      });

      print("video loading is end");
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        primary: true,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(grid.length, (index) => grid[index]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
