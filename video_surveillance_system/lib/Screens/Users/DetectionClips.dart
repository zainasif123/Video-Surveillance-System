import 'package:flutter/material.dart';

class DetectionClips extends StatefulWidget {
  final String id;
  DetectionClips({super.key, required this.id});

  @override
  State<DetectionClips> createState() => _DetectionClipsState();
}

class _DetectionClipsState extends State<DetectionClips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detection Clips" + widget.id),
      ),
    );
  }
}
