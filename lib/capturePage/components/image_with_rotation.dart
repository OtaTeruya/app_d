import 'package:app_d/capturePage/utils/image_manager.dart';
import 'package:flutter/material.dart';

class ImageWithRotation extends StatelessWidget {
  final String imgPath;
  final int rotationAngle;
  final VoidCallback? rotateImage;
  final VoidCallback? deleteImage;

  const ImageWithRotation({
    super.key,
    required this.imgPath,
    required this.rotationAngle,
    required this.rotateImage,
    required this.deleteImage
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedRotation(
            turns: rotationAngle / 360,
            duration: const Duration(milliseconds: 300),
            child: ImageManager().getImage(imgPath),
          ),
        ),
        if (rotateImage != null) ...[
          Positioned(
            bottom: 0,
            right: 8,
            child: Opacity(
              opacity: 0.3,
              child: IconButton(
                onPressed: rotateImage,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: SizedBox(
                  width: 32,
                  height: 32,
                  child: Image.asset('images/icon_rotate.png'),
                ),
              ),
            ),
          )
        ],
        if (deleteImage != null) ...[
          Positioned(
            bottom: 0,
            left: 8,
            child: Opacity(
              opacity: 0.3,
              child: IconButton(
                onPressed: deleteImage,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: SizedBox(
                  width: 32,
                  height: 32,
                  child: Image.asset('images/icon_delete.png'),
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}