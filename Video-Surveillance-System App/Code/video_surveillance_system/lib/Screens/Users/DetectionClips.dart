import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("" + widget.id),
        backgroundColor: Colors.white70,
      ),
      body: ImageGallery(),
    );
  }
}

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/images'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data); // Decode the JSON response
        final List<dynamic> imageList = data['images'];
        print(imageList); // Access the 'images' key
        setState(() {
          _imageUrls = List<String>.from(
              imageList); // Convert the list to a list of strings
        });
        print(_imageUrls);
      } else {
        print('Failed to load images: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching images: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return image(index);
        },
      ),
    );
  }

  Widget image(index) {
    try {
      return Image.network('http://10.0.2.2:5000/images/${_imageUrls[index]}');
    } catch (e) {
      return SizedBox();
    }
  }
}
