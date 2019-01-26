import 'package:flutter/material.dart';
import 'package:interco/model/question.dart';
import 'package:interco/model/symbol.dart';

class QuizButtonGroupWidget extends StatefulWidget {
    final List<Symbol> options;
    final int correctIndex;
    final SymbolField field;

    QuizButtonGroupWidget({Key key, this.options, this.correctIndex, this.field}) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return QuizButtonGroupWidgetState();
    }
}

class QuizButtonGroupWidgetState extends State<QuizButtonGroupWidget> {
    var buttonColors;

    static const _nameTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0);
    static const _memoTextStyle = TextStyle(fontSize: 16.0);

    @override
    void initState() {
        super.initState();
        buttonColors = List.generate(widget.options.length, (it) => Colors.amber);
    }

    @override
    Widget build(BuildContext context) {
        return _buildAnswersGridWidget();
    }

    _buildAnswersGridWidget() {
        var children = _createChildren();

        return Table(
            defaultColumnWidth: FractionColumnWidth(.5),
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            children: [
                TableRow(children: [children[0], children[1]]),
                TableRow(children: [children[2], children[3]])
            ],
        );
    }


    _createChildren() {
        var children = <Widget>[];
        for (int i = 0; i < widget.options.length; ++i) {
            children.add(_buildButton(widget.options[i], i));
        }
        return children;
    }

    _buildButton(Symbol symbol, int index) {
        debugPrint("Build button $index");
        return Container(padding: EdgeInsets.all(4.0),
            child:ButtonTheme(
                minWidth: double.infinity,

                child: RaisedButton(
                    child: Container(child:_buildAnswerButtonChild(symbol)),
                    color: buttonColors[index],
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {
                        debugPrint("onPressed");
                        setState(() {
                            buttonColors[widget.correctIndex] = Colors.green;
                            if (index != widget.correctIndex) {
                                buttonColors[index] = Colors.red;
                            }
                        });
                    },
                ),
            ));
    }

    _buildAnswerButtonChild(Symbol symbol) {
        switch (widget.field) {
            case SymbolField.FLAG:
                return Image.asset(symbol.imagePath, height: 50.0,);
            case SymbolField.NAME:
                return Text(
                    symbol.name,
                    style: _nameTextStyle,
                );
            case SymbolField.MEMO:
                return Text(
                    symbol.memo,
                    style: _memoTextStyle,
                );
        }
    }

}