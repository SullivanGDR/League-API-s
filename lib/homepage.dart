import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _moyenneEBC = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 25.0),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white12,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            height: 55,
            child: TextFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Rechercher un champion"),
              validator: (valeur) {
                if (valeur == null || valeur.isEmpty) {
                  return 'Veuillez entrer la moyenne EBC des grains';
                } else {
                  _moyenneEBC = double.parse(valeur);
                }
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white12,
        height: 50,
      ),
    );
  }
}
