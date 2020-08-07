import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;
  final Widget placeholder;
  PlatformImage(
      {@required this.url,
      this.width = 300,
      this.height = 300,
      this.fit,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return url == null || url.isEmpty
        ? Container(width: this.width, height: this.height)
        : !kIsWeb
            ? CachedNetworkImage(
                imageUrl: url,
                fit: this.fit,
                width: this.width,
                height: this.height,
                fadeInDuration: Duration(milliseconds: 500),
                placeholder:
                    placeholder == null ? null : (c, a) => this.placeholder)
            : Image(
                image: NetworkImage(url),
                height: height,
                width: width,
                fit: this.fit,
              );
  }
}
