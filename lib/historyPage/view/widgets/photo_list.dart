import 'dart:io';

import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {
  final List<String> photoPaths;
  final List<String> photoTimes;

  const PhotoList({
    super.key,
    required this.photoPaths,
    required this.photoTimes,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: ListView.builder(
        itemCount: photoPaths.length + photoTimes.length,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            int timeIndex = index ~/ 2;
            //String formattedTime = DateFormat('HH:mm:ss').format(photoTimes[timeIndex]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(photoTimes[timeIndex], textAlign: TextAlign.center),
            );
          } else {
            int pathIndex = index ~/ 2;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Image.file(File(photoPaths[pathIndex]), fit: BoxFit.cover),
            );
          }
        },
      ),
    );
  }
}
