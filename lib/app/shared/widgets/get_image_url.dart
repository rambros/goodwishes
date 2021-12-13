import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GetImageUrl extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  

  const GetImageUrl({required this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (width != null && height != null) {
      return Container(width: width, height: height, child: _imageBox());
    } else {
      return Container(child: _imageBox());
    }
  }

  Widget _imageBox() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(6.0),
          bottomLeft: const Radius.circular(6.0)),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
