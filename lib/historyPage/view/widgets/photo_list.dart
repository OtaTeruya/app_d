import 'dart:io';

import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {
  final List<String> photoPaths;

  const PhotoList({super.key, required this.photoPaths});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: photoPaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Image.file(File(photoPaths[index]), fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
