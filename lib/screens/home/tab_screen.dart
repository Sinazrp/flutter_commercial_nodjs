import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_commercial_nodjs/features/account/screens/account_screen.dart';
import 'package:flutter_commercial_nodjs/screens/home/home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const route = "TabScreen";

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List pages = [
    HomeScreen(),
    AccountScreen(),
    const Center(
      child: Text('kart'),
    )
  ];
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 0
                              ? Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Acount',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 1
                              ? Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 2
                              ? Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: badges.Badge(
                  stackFit: StackFit.passthrough,
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: Color.fromARGB(83, 255, 255, 255)),
                  badgeContent: Text('2'),
                  child: const Icon(Icons.shop_2_outlined)),
            ),
          )
        ],
      ),
    );
  }
}