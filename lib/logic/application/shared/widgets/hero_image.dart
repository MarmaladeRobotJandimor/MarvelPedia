import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marvelhero/logic/application/shared/widgets/platform_image.dart';

class HeroImage extends StatelessWidget {
  final String image;
  final Color color;
  final int id;
  final double height;
  final double width;
  final BoxFit fit;
  final Radius radius;

  HeroImage(
      {this.image,
      this.color = Colors.transparent,
      this.id,
      this.width,
      this.height,
      this.radius = const Radius.circular(0),
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: this.radius, bottomLeft: this.radius),
          child: PlatformImage(
            width: this.width,
            height: this.height,
            url: this.image,
            fit: this.fit,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                  Colors.transparent,
                  color,
                ],
                    stops: [
                  0,
                  1
                ])),
          ),
        )
      ],
    );
  }
}
