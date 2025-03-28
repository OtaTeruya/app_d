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
      height: 600,
      child: ListView.builder(
        itemCount: photoTimes.length + photoTitles.length + photoPaths.length,
        itemBuilder: (context, index) {
          int itemIndex = index ~/ 3;
          if (index % 3 == 0) {
            return Text(photoTimes[itemIndex], textAlign: TextAlign.center);
          } else if (index % 3 == 1) {
            return Text(
              photoTitles[itemIndex],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.file(File(photoPaths[itemIndex]), fit: BoxFit.cover),
            );
          }
        },
      ),
    );
  }
}
