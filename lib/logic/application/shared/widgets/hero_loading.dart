import 'package:flutter/material.dart';

class HeroLoading extends StatelessWidget {
  final String image;
  final String message;

  HeroLoading(this.image, this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage(this.image)),
          SizedBox(height: 20),
          Text(this.message.toUpperCase(),
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
