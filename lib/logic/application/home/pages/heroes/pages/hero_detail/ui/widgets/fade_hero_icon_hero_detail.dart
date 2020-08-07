import 'package:flutter/material.dart';
import 'package:marvelhero/logic/application/shared/util/marvel_util.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_back_button.dart';
import 'package:marvelhero/logic/application/shared/widgets/platform_image.dart';

class HeroDetailFadeHeroIcon extends StatefulWidget {
  final ScrollController scrollController;
  final String image;
  final double heightOfAppBar;

  HeroDetailFadeHeroIcon(
      this.scrollController, this.image, this.heightOfAppBar);

  @override
  _FadeHeroIconState createState() => _FadeHeroIconState();
}

class _FadeHeroIconState extends State<HeroDetailFadeHeroIcon> {
  double _offset;
  double buttonSize = 40;

  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(_setOffset);
  }

  double _calculateFadeOnScroll(bool visibleOnTop) {
    if (_offset != null && _offset >= 0 && _offset <= widget.heightOfAppBar) {
      var percentage =
          MarvelUtil.inverserThreeRule(widget.heightOfAppBar, _offset) / 100;
      return visibleOnTop ? percentage : 1 - percentage;
    } else if (_offset != null &&
        _offset >= 0 &&
        _offset >= widget.heightOfAppBar) {
      return visibleOnTop ? 1.0 : 0.0;
    } else {
      return visibleOnTop ? 0.0 : 1.0;
    }
  }

  double _calculateTranslateOnScroll(double distance) {
    if (_offset != null && _offset >= 0 && _offset <= widget.heightOfAppBar) {
      var percentage =
          MarvelUtil.inverserThreeRule(widget.heightOfAppBar, _offset) / 100;
      var moveTo = distance * percentage;
      return moveTo;
    } else if (_offset != null &&
        _offset >= 0 &&
        _offset >= widget.heightOfAppBar) {
      return distance;
    } else {
      return 0.0;
    }
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(40), left: Radius.circular(40)),
        onTap: () {
          Navigator.of(context).maybePop();
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(_calculateTranslateOnScroll(buttonSize), 0),
                    child: Opacity(
                      opacity: _calculateFadeOnScroll(true),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                              child: PlatformImage(
                                  fit: BoxFit.cover, url: widget.image))),
                    ),
                  ),
                  Opacity(
                    opacity: _calculateFadeOnScroll(false),
                    child: SizedBox(
                        height: buttonSize,
                        width: buttonSize,
                        child: CircleAvatar(backgroundColor: Colors.white)),
                  ),
                  SizedBox(
                      height: buttonSize,
                      width: buttonSize,
                      child: HeroBackButtonIcon()),
                ],
              ),
              Opacity(
                opacity: 0,
                child: SizedBox(
                  height: buttonSize,
                  width: buttonSize,
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                          child: PlatformImage(
                              fit: BoxFit.cover, url: widget.image))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
