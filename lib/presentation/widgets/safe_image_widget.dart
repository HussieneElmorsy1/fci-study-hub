import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SafeImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final BoxFit? fit;

  const SafeImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.errorWidget,
    this.fit,
  });

  Future<bool> _isSvgValid() async {
    try {
      final loader = SvgAssetLoader(imagePath);
      await loader.loadBytes(null);
      return true;
    } catch (e) {
      debugPrint("SVG Error: $e");
      return false;
    }
  }

  Future<bool> _isImageValid(BuildContext context) async {
    try {
      await precacheImage(AssetImage(imagePath), context);
      return true;
    } catch (e) {
      debugPrint("Image Error: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSvg = imagePath.toLowerCase().endsWith('.svg');

    return FutureBuilder<bool>(
      future: isSvg ? _isSvgValid() : _isImageValid(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == false) {
          return errorWidget ??
              const Icon(Icons.error, color: Colors.red);
        }

        return isSvg
            ? SvgPicture.asset(
                imagePath,
                width: width,
                height: height,
                fit: fit ?? BoxFit.contain,
              )
            : Image.asset(
                imagePath,
                width: width,
                height: height,
                fit: fit ?? BoxFit.cover,
              );
      },
    );
  }
}