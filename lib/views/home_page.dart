import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Story App"),
        ),
        body: Builder(builder:(context) =>  OutlinedButton(
              onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
          content: Text('A SnackBar has been shown.'),
          ),
          );
          },
            child: const Text('Show SnackBar'),
          ),
          ),




        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('item 1'),
                onTap: () {
                  const SnackBar(content: Text("Clicked on this "));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
