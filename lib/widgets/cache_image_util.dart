import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';

class CacheImageUtil extends StatelessWidget {
  CacheImageUtil(
      {Key? key,
      this.image,
      this.default_image = "assets/images/landing/images-1.jpg",
      this.height = 100,
      this.width = 100,
      this.fit = BoxFit.contain})
      : super(key: key);
  String? image;
  double width = 100;
  double height = 100;
  String default_image;
  BoxFit fit = BoxFit.contain;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      alignment: Alignment.topCenter,
      height: height,
      fit: fit,
      imageUrl: IMAGE_DOMAIN + "/" + image.toString().replaceAll("\\", "/"),
      // imageUrl: IMAGE_DOMAIN + image.toString().split("public")[1],
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(
          child: Image.asset(
        default_image,
        height: height,
        width: width,
        fit: fit,
      )),
    );
  }
}
