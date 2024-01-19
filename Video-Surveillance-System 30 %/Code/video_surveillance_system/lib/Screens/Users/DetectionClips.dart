import 'package:flutter/material.dart';

class DetectionClips extends StatefulWidget {
  final String id;
  DetectionClips({super.key, required this.id});

  @override
  State<DetectionClips> createState() => _DetectionClipsState();
}

class _DetectionClipsState extends State<DetectionClips> {
  List<String> notes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("" + widget.id),
      ),
      body: Container(
        child: Column(children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text("Notes 1"),
                  leading: Icon(Icons.title),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.abc),
                  ),
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
