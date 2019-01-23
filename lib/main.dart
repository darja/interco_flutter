import 'package:flutter/material.dart';
import 'package:interco/home.dart';

void main() => runApp(IntercoApp());

class IntercoApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Interco',
            theme: ThemeData(
                primaryColor: Color.fromARGB(255, 21, 67, 96),
            ),
            home: Home(),

        );
    }
}
