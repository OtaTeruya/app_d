import 'dart:io';

import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {
  final List<String> photoTimes;
  final List<String> photoTitles;
  final List<String> photoPaths;

  const PhotoList({
    super.key,
    required this.photoTimes,
    required this.photoTitles,
    required this.photoPaths,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: ListView.builder(
        itemCount: photoPaths.length * 3,
        itemBuilder: (context, index) {
          int itemIndex = index ~/ 3;
          if (index % 3 == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(photoTimes[itemIndex], textAlign: TextAlign.center),
            );
          } else if (index % 3 == 1) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                photoTitles[itemIndex],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Image.file(File(photoPaths[itemIndex]), fit: BoxFit.cover),
            );
          }
        },
      ),
    );
  }
}
