import 'package:flutter/material.dart';

class SliverFitText extends StatelessWidget {
  const SliverFitText({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    final settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final deltaExtent = settings.maxExtent - settings.minExtent;
    final t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0) as double;
    final scaleValue = Tween<double>(begin: 1.5, end: 1.0).transform(t);
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
        duration: Duration(microseconds: 1000),
        width: constraints.maxWidth / scaleValue,
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'marvel', fontSize: 40),
          overflow: TextOverflow.visible,
        ),
      );
    });
  }
}