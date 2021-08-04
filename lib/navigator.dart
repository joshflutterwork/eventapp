import 'package:eventapp/page/chat.dart';
import 'package:eventapp/page/explore.dart';
import 'package:eventapp/page/home.dart';
import 'package:eventapp/page/profile.dart';
import 'package:flutter/material.dart';

class NavigatorButton extends StatefulWidget {
  @override
  _NavigatorButtonState createState() => _NavigatorButtonState();
}

class _NavigatorButtonState extends State<NavigatorButton> {
  PageController _pageController =
      PageController(initialPage: 0, keepPage: false);
  int bottomSelectedIndex = 0;

  Future bottomTapped(int index) async {
    bottomSelectedIndex = index;
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);

    setState(() {});
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          activeIcon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/homeicon.png',
              color: Colors.white,
              // height: 45,
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/homeicon.png',
              // height: 45,
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          activeIcon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/exploreicon.png',
              color: Colors.white,
              // height: 45,
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/exploreicon.png',
              // height: 45,
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          activeIcon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/chaticon.png',
              // height: 45,
              color: Colors.white,
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/chaticon.png',
              // height: 45,
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          activeIcon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/profileicon.png',
              // height: 45,
              color: Colors.white,
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/profileicon.png',
              // height: 45,
            ),
          ),
          label: ''),
    ];
  }

  Widget bottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
          setState(() {});
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  Widget getPageViewAdmin() => PageView(
        controller: _pageController,
        children: [HomePage(), ExplorePage(), ChatPage(), ProfilePage()],
        onPageChanged: (index) {
          pageChanged(index);
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,
        body: getPageViewAdmin(),
        bottomNavigationBar: bottomNavigation());
  }
}
