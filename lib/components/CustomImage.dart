import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double? imageSize;
  final Color? iconLightColor;
  final String? imagePath;
  final bool? isNetworkImage;
  const CustomImage({
    required this.imagePath,
    this.imageSize,
    this.iconLightColor,
    this.isNetworkImage,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: isNetworkImage == true
          ? ClipRRect(
              borderRadius: BorderRadius.circular(imageSize!),
              child: Image.network(
                imagePath.toString(),
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, child) {
                  return Icon(
                    Icons.error,
                    color: iconLightColor,
                    size: imageSize,
                  );
                },
              ),
            )
          : Image(
              image: AssetImage(imagePath.toString()),
              width: imageSize,
              height: imageSize,
              errorBuilder: (context, error, child) {
                return Icon(
                  Icons.error,
                  color: iconLightColor,
                  size: imageSize,
                );
              },
              color: iconLightColor,
            ),
    );
  }
}
