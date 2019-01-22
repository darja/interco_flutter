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
                primarySwatch: Colors.blue,
            ),
            home: Home(),

        );
    }
}
