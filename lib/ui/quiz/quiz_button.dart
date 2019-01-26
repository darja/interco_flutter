import 'package:flutter/material.dart';

class QuizButtonGroupWidget extends StatefulWidget {
    final int itemsCount;
    final Function itemBuilder;
    final Function answerHighlighter;
    final Function onAnswerSelected;

    QuizButtonGroupWidget({Key key,
        @required this.itemsCount,
        @required this.itemBuilder,
        @required this.answerHighlighter,
        @required this.onAnswerSelected}) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        debugPrint("CreateState");
        return QuizButtonGroupWidgetState();
    }
}

class QuizButtonGroupWidgetState extends State<QuizButtonGroupWidget> {
    var buttonColors;

    @override
    void initState() {
        super.initState();
        debugPrint("InitState");
    }

    @override
    Widget build(BuildContext context) {
        return _buildAnswersGridWidget();
    }

    _buildAnswersGridWidget() {
        var children = _createChildren();
        List<TableRow> rows = [];
        for (int i = 0; i < children.length; i += 2) {
            rows.add(TableRow(
                children: [children[i], children[i + 1]]
            ));
        }

        return Table(
            defaultColumnWidth: FractionColumnWidth(.5),
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            children: rows,
        );
    }


    _createChildren() {
        var children = <Widget>[];
        for (int i = 0; i < widget.itemsCount; ++i) {
            children.add(_buildButton(i));
        }
        return children;
    }

    _buildButton(int index) {
        return Container(padding: EdgeInsets.all(4.0),
            child:ButtonTheme(
                minWidth: double.infinity,

                child: RaisedButton(
                    child: Container(child:widget.itemBuilder(index)),
                    color: widget.answerHighlighter(index),
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {
                        widget.onAnswerSelected(index);
                    },
                ),
            ));
    }
}