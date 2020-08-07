import 'package:flutter/material.dart';

class HeroInformation extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;

  HeroInformation({@required this.icon, @required this.name, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(this.icon, color: this.color, size: 30),
        SizedBox(height: 10),
        Text(this.name,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'marvel',
                color: this.color,
                fontSize: 18))
      ],
    );
  }
}