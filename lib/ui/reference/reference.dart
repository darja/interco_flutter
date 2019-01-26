import 'package:flutter/material.dart';
import 'package:interco/services/SymbolsProvider.dart';
import 'package:interco/model/symbol.dart';
import 'package:interco/main.dart';

class ReferenceWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _ReferenceWidgetState();
    }
}

class _ReferenceWidgetState extends State<ReferenceWidget> {
    SymbolsProvider _symbolsProvider;

    @override
    void initState() {
        super.initState();
        setState(() {
            _symbolsProvider = getIt.get<SymbolsProvider>();
        });
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            backgroundColor: Colors.amber,
            body: _buildBody(context),
        );
    }

    Widget _buildBody(BuildContext context) {
        return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _symbolsProvider.getSymbols().length,
            itemBuilder: _buildSymbolItem
        );
    }

    Widget _buildSymbolItem(BuildContext context, int index) {
        Symbol symbol = _symbolsProvider.getSymbol(index);

        return new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Card(
                child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        new ListTile(
                            leading: new Text(symbol.name,
                                style: new TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                            ),
                            title: new Text(
                                symbol.memo,
                                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                            trailing: Image.asset(symbol.imagePath, height: 30.0,),
                        ),
                    ],
                ),
            ),
        );
    }
}
