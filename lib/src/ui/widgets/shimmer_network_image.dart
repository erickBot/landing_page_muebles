import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      imageUrl: imageUrl,
      fit: fit,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(height: height, width: width, color: Colors.white),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
    // return Image.network(
    //   width: width,
    //   imageUrl,
    //   fit: fit,
    //   // 👇 Se usa el loadingBuilder para aplicar el shimmer mientras carga
    //   loadingBuilder: (context, child, loadingProgress) {
    //     if (loadingProgress == null) return child; // Imagen cargada ✅
    //     return Shimmer.fromColors(
    //       baseColor: baseColor,
    //       highlightColor: highlightColor,
    //       child: Container(height: height, width: width, color: Colors.white),
    //     );
    //   },
    //   errorBuilder: (context, error, stackTrace) {R
    //     return const Icon(Icons.broken_image, color: Colors.grey);
    //   },
    // );
  }
}
