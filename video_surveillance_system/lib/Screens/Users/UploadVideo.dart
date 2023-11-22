import 'dart:io';

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
    _videoPlayerController!.dispose();
  }

  _pickVideo() async {
    final vidoe = await picker.pickVideo(source: ImageSource.gallery);

    _video = File(vidoe!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((value) {
        setState(() {});
        _videoPlayerController!.play();
        _videoPlayerController!.setLooping(true);
        _videoPlayerController!.setVolume(2);
      });
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
          content: Text("No video selected."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Video"),
      ),
      body: Column(
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
            Text("Click to Pick Video to Select Video"),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pickVideo();
                },
                child: Text("Pick Video from gallery"),
              ),
              ElevatedButton(
                onPressed: _showResultSnackBar,
                child: Text('Show Result'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Upload To Server'),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _videoPlayerController!.dispose();
        },
        child: Icon(Icons.cancel),
      ),
    );
  }
}
