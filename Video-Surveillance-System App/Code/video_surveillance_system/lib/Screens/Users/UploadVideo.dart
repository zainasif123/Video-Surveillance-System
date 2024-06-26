import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPickerScreenDemo extends StatefulWidget {
  const VideoPickerScreenDemo({super.key});

  @override
  State<VideoPickerScreenDemo> createState() => _VideoPickerScreenDemoState();
}

class _VideoPickerScreenDemoState extends State<VideoPickerScreenDemo> {
  VideoPlayerController? _videoPlayerController;
  File? _video;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    // _videoPlayerController =
    //     VideoPlayerController.asset("images/Explosion032_x264_2.mp4");
  }

  @override
  void dispose() {
    super.dispose();

    _videoPlayerController?.dispose();
  }

  _pickVideo() async {
    final vidoe = await picker.pickVideo(source: ImageSource.gallery);
    if (vidoe != null) {
      _video = File(vidoe.path);
      _videoPlayerController = VideoPlayerController.file(_video!)
        ..initialize().then((value) {
          setState(() {});
          _videoPlayerController!.play();
          _videoPlayerController!.setLooping(true);
          _videoPlayerController!.setVolume(2);
        });
    } else {}
  }

  void _showResultSnackBar() {
    if (_video != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Selected video path: ${_video!.path}"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Video Path not exist"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 600.0),
        ),
      );
    }
  }

  Future<void> _uploadVideo() async {
    if (_video == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("No Video Selected From Gallery"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 600.0),
        ),
      );
    }

    final url = Uri.parse('http://10.0.2.2:5000/upload_video');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('video', _video!.path));
      final response = await request.send().timeout(Duration(minutes: 2));
      print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("SuccessFully Uploaded:"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 580.0),
          ),
        );
        print('Video uploaded successfully');
      } else {
        print('Failed to upload video. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading video: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detect Violance"),
        backgroundColor: Colors.white70,
      ),
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_video != null)
              _videoPlayerController!.value.isInitialized
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height /
                          2, // Set the height you desire
                      child: AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                    )
                  : Placeholder()
            else
              Text(
                "Click to Pick Video from the Gallery",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video from gallery",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: _showResultSnackBar,
                  child: Text('Show Result',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _uploadVideo();
                  },
                  child: Text('Upload To Server',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        if (_videoPlayerController != null) {
                          _videoPlayerController!.dispose();
                        }
                      },
                      child: Text(
                        "Cancle Selected Video",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
