import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:marvelhero/logic/application/shared/util/marvel_util.dart';

class LikeHeroButton extends StatelessWidget {
  final double size;
  final ScrollController scrollController;
  final double heightOfAppBar;

  LikeHeroButton({this.size: 40, this.scrollController, this.heightOfAppBar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Stack(
        children: <Widget>[
          FadeContainerOnScroll(
              size: this.size,
              scrollController: this.scrollController,
              heightOfAppBar: this.heightOfAppBar),
          Center(
            child: LikeButton(
              size: this.size,
              circleColor:
                  CircleColor(start: Colors.red[100], end: Colors.red[300]),
              bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.purple,
                  dotSecondaryColor: Colors.pink),
              likeBuilder: (bool isLiked) {
                return Icon(!isLiked ? FontAwesomeIcons.heart : Icons.favorite,
                    color: isLiked ? Colors.red : Colors.black, size: 20);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FadeContainerOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double heightOfAppBar;
  final double size;

  FadeContainerOnScroll(
      {this.size, this.scrollController, this.heightOfAppBar});

  @override
  _FadeContainerOnScrollState createState() => _FadeContainerOnScrollState();
}

class _FadeContainerOnScrollState extends State<FadeContainerOnScroll> {
  double _offset;

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

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateFadeOnScroll(false),
      child: Center(
        child: Container(
            height: widget.size,
            width: widget.size,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
      ),
    );
  }
}
