import 'package:flutter/material.dart';

import 'Pages/List/ListItem.dart';
import 'Pages/Notes/Notes.dart';

void main() {
  runApp(
    MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final listBody = [ListItem(), Note()];
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listBody[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[400],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.message), label: 'Ghi chú'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Dictionary')
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
