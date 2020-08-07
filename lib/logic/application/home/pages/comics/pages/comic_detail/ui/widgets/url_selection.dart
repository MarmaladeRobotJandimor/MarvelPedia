import 'package:flutter/material.dart';
import 'package:marvelhero/data/shared_models/urls/marvel_url.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlSelection extends StatefulWidget {
  final List<MarvelUrl> urls;

  UrlSelection(this.urls);
  @override
  State<StatefulWidget> createState() => _UrlSelectedState();
}

class _UrlSelectedState extends State<UrlSelection> {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: DropdownButton<MarvelUrl>(
        hint: Center(
          child: Text(
            'LINKS',
            style: TextStyle(
                color: Colors.white, fontFamily: 'marvel', fontSize: 20),
          ),
        ),
        isExpanded: true,
        iconSize: 24,
        elevation: 16,
        underline: Container(),
        onChanged: (MarvelUrl newValue) {
          _launchURL(newValue.url);
        },
        items: widget.urls.map<DropdownMenuItem<MarvelUrl>>((MarvelUrl value) {
          return DropdownMenuItem<MarvelUrl>(
            value: value,
            child: Text(
              value.type.toUpperCase(),
              style: TextStyle(color: Colors.black, fontFamily: 'marvel'),
            ),
          );
        }).toList(),
      ),
    );
  }
}
