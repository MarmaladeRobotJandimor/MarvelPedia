import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageBottomNavigation extends StatefulWidget {
  final PageController pageController;
  final int currentTab;

  HomePageBottomNavigation(
      {@required this.pageController, @required this.currentTab});

  @override
  _HomePageBottomNavigationState createState() =>
      _HomePageBottomNavigationState();
}

class _HomePageBottomNavigationState extends State<HomePageBottomNavigation> {
  int _currentTab;

  @override
  Widget build(BuildContext context) {
    _currentTab = widget.currentTab;
    return BottomNavigationBar(
      onTap: (index) {
        widget.pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
        setState(() {
          _currentTab = widget.currentTab;
        });
      },
      currentIndex: _currentTab,
      unselectedItemColor: Colors.grey[400],
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(fontFamily: 'marvel'),
      unselectedLabelStyle: TextStyle(fontFamily: 'marvel'),
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users), title: Text('Heroes')),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bookOpen), title: Text('Comics')),
      ],
    );
  }
}
