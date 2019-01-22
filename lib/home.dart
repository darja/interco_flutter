import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Interco"),
          ),
          bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text("Reference")),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_help), title: Text("Quiz")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                title: Text("Statistics"))
          ]),
          body: Center(
            child: Text("Hello there!"),
          ),
        );
  }
}
