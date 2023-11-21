import 'package:flutter/material.dart';
import 'package:lol_api/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League Api\'s',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'League Champion\'s'),
      debugShowCheckedModeBanner: false,
    );
  }
}
