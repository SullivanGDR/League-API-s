import 'package:flutter/material.dart';
import 'package:lol_api/all_champions_page.dart';
import 'package:lol_api/class/database.dart';
import 'package:lol_api/collections_page.dart';
import 'package:lol_api/home_page.dart';
import 'package:lol_api/settings_page.dart';
import 'package:lol_api/splashscreen_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:lol_api/champions_icon_icons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseCollections().initDb();
  DatabaseCollections().printDatabaseContents();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League Api\'s',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const MyHomePage(),
        '/champions': (BuildContext context) => const FabricationPage(),
      },
    );
  }
}

class MyAppBar extends StatelessWidget {
  final Color colorGrey = const Color(0xFFA09B8C);
  final Color colorBlue = const Color(0xFF005A82);

  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white12,
      title: Text(
        'LOL.GG',
        style: TextStyle(
          color: colorGrey,
          fontSize: 30,
          fontFamily: 'LoLFontBold',
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(CupertinoIcons.person, color: colorGrey, size: 30.0),
            onPressed: () {}),
      ],
    );
  }
}

class MyBottomAppBar extends StatelessWidget {
  final Color colorGrey = const Color(0xFFA09B8C);
  final Color colorBlue = const Color(0xFF005A82);

  const MyBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white12,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MyHomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var fadeAnimation = animation.drive(tween);
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ));
              },
              icon: const Icon(CupertinoIcons.house_fill),
              color: colorGrey),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const FabricationPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = 0.0;
                      const end = 1.0;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var fadeAnimation = animation.drive(tween);
                      return FadeTransition(
                        opacity: fadeAnimation,
                        child: child,
                      );
                    },
                  ));
            },
            icon: const Icon(ChampionsIcon.helmet),
            iconSize: 47,
            padding: const EdgeInsets.only(bottom: 0),
            color: colorGrey,
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CollectionsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var fadeAnimation = animation.drive(tween);
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ));
              },
              icon: const Icon(CupertinoIcons.collections_solid),
              color: colorGrey),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SettingsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var fadeAnimation = animation.drive(tween);
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ));
              },
              icon: const Icon(CupertinoIcons.gear_alt_fill),
              color: colorGrey),
        ],
      ),
    );
  }
}
