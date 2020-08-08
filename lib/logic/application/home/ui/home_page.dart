import 'package:flutter/material.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/ui/heroes_page.dart';
import 'wdigets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController _pageController = PageController();
  // int _currentTab = 0;

  // pageChanged(int index) {
  //   setState(() {
  //     _currentTab = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomeAppBar(), body: HeroesPage());
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    // floatingActionButton: HomeFavouriteButton(),
    // bottomNavigationBar: HomePageBottomNavigation(
    //     pageController: _pageController, currentTab: _currentTab),
    // body: HomeContent(
    //     pageController: _pageController,
    //     onPageChanged: (tab) => pageChanged(tab)));
  }
}
