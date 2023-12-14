import 'package:flutter/material.dart';
import 'package:lol_api/all_champions_page.dart';
import 'package:lol_api/class/database.dart';
import 'package:lol_api/collections_page.dart';
import 'package:lol_api/home_page.dart';
import 'package:lol_api/settings_page.dart';
import 'package:lol_api/splashscreen_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:lol_api/champions_icon_icons.dart';

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