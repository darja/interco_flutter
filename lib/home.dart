import 'package:flutter/material.dart';
import 'package:interco/ui/quiz/quiz.dart';
import 'package:interco/ui/reference/reference.dart';

class Home extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _HomeState();
    }
}

class _HomeState extends State<Home> {
    int _selectedTabIndex = 0;
    final List<Widget> _tabContent = [
        ReferenceWidget(),
        QuizWidget(),
        Center(child: Text("Statistics")),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Interco"),
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: onTabSelected,
                currentIndex: _selectedTabIndex,
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list), title: Text("Reference")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.live_help), title: Text("Quiz")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_box),
                        title: Text("Statistics"))
                ]),
            body: _tabContent[_selectedTabIndex],
        );
    }

    void onTabSelected(int index) {
        setState(() {
            _selectedTabIndex = index;
        });
    }
}
