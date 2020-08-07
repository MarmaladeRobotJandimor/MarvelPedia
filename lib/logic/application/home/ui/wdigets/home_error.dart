import 'package:flutter/material.dart';

class HomeError extends StatelessWidget {
  final String errorMessage;

  HomeError(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: Text(this.errorMessage,
              style: Theme.of(context).textTheme.headline1)),
    );
  }
}
