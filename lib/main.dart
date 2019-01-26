import 'package:flutter/material.dart';
import 'package:interco/home.dart';
import 'package:get_it/get_it.dart';
import 'package:interco/services/QuizProvider.dart';
import 'package:interco/services/SymbolsProvider.dart';
import 'dart:async';

GetIt getIt = new GetIt();
void main() => runApp(IntercoApp());

class IntercoApp extends StatelessWidget {
    Future<int> appStartup(BuildContext context) async {
        debugPrint("Loading");

        var symbolsProvider = new SymbolsProvider();
        await symbolsProvider.init(DefaultAssetBundle.of(context));
        getIt.registerSingleton<SymbolsProvider>(symbolsProvider);

        var quizProvider = new QuizProvider(symbols: symbolsProvider.getSymbols());
        getIt.registerSingleton<QuizProvider>(quizProvider);

        debugPrint("End Loading");

        return 1;
    }

    Widget buildBody(BuildContext context) {
        return FutureBuilder<int>(
            future: appStartup(context),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {

                if (snapshot.connectionState == ConnectionState.done) {
                    return Home();
                } else {
                    return buildLoadingWidget();
                }
            },
        );
    }

    Widget buildLoadingWidget() {
        return Scaffold(
            body: Center(child: Text("Loading")),
        );
    }

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        print('build');
        return MaterialApp(
            title: 'Interco',
            theme: ThemeData(
                primaryColor: Color.fromARGB(255, 21, 67, 96),
            ),
            home: buildBody(context),
        );
    }
}
