import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lol_api/all_champions_page.dart';
import 'package:lol_api/collections_page.dart';
import 'package:lol_api/home_page.dart';
import 'package:lol_api/settings_page.dart';
import 'package:line_icons/line_icons.dart';

import 'champions_icon_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);
  Color colorGold = const Color(0xFFC89B3C);

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(),
    const FabricationPage(),
    const CollectionsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 5),
              child: GNav(
                rippleColor: colorGrey,
                hoverColor: colorGrey,
                gap: 8,
                activeColor: colorGrey,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.black26,
                color: colorGrey,
                tabs: const [
                  GButton(
                    icon: CupertinoIcons.house_fill,
                    text: 'Home',
                  ),
                  GButton(
                    icon: ChampionsIcon.helmet,
                    iconSize: 46,
                    text: 'Champions',
                    padding: EdgeInsets.all(0),
                  ),
                  GButton(
                    icon: CupertinoIcons.collections_solid,
                    text: 'Collections',
                  ),
                  GButton(
                    icon: CupertinoIcons.gear_alt_fill,
                    text: 'Settings',
                  )
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}