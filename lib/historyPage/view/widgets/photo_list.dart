import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../capturePage/utils/image_manager.dart';

class PhotoList extends StatelessWidget {
  final List<String>? photoTimes;
  final List<String>? photoTitles;
  final List<String>? photoPaths;
  final void Function(String photoTitle, String photoPath) openPopup;

  const PhotoList({
    super.key,
    required this.photoTimes,
    required this.photoTitles,
    required this.photoPaths,
    required this.openPopup
  });

  @override
  Widget build(BuildContext context) {
    if (photoPaths == null || photoTimes == null || photoTitles == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (photoPaths!.length != photoTimes!.length || photoTimes!.length != photoTitles!.length) {
      return Center(child: CircularProgressIndicator());
    }
    else {
      return Column(
        children: [
          for (int i = 0; i < photoTimes!.length; i++) ...[
            Divider(),
            GestureDetector(
                onTap: () {openPopup(photoTitles![i], photoPaths![i]);},
                child: Column(
                  children: [
                    Text(photoTimes![i],
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          photoTitles![i],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: ImageManager().getImage(photoPaths![i])
                    )
                  ],
                )
            )
          ],
          Gap(8)
        ],
      );
    }
  }
}
