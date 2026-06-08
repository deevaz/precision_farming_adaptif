import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kelola_tani/app/shared/widgets/app_cached_image.dart';

class AppImageRenderer extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;

  const AppImageRenderer({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = 15,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Icon(Icons.image_not_supported, color: Colors.grey.shade400),
      );
    }

    if (imageUrl.startsWith('/') || imageUrl.contains(r'\')) {
      final file = File(imageUrl);

      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: file.existsSync()
            ? Image.file(file, width: width, height: height, fit: fit)
            : Container(
                width: width,
                height: height,
                color: Colors.grey.shade200,
                child: const Center(child: Text("File Hilang")),
              ),
      );
    }

    return AppCachedImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      borderRadius: borderRadius,
      fit: fit,
    );
  }
}
