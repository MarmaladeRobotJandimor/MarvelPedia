import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroBackButtonIcon extends StatelessWidget {
  /// Creates an icon that shows the appropriate "back" image for
  /// the current platform (as obtained from the [Theme]).
  const HeroBackButtonIcon({Key key}) : super(key: key);

  /// Returns the appropriate "back" icon for the given `platform`.
  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Icons.arrow_back_ios;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        break;
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) =>
      Icon(_getIconData(Theme.of(context).platform), color: Colors.black);
}
