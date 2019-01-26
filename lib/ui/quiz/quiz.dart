import 'package:flutter/material.dart';
import 'package:interco/main.dart';
import 'package:interco/model/question.dart';
import 'package:interco/model/symbol.dart';
import 'package:interco/services/QuizProvider.dart';

class QuizWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _QuizWidgetState();
    }
}

class _QuizWidgetState extends State<QuizWidget> {
    QuizProvider _quizProvider;
    Question _question;

    var _nameTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0);
    var _memoTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
    var _buttonTextStyle = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400
    );

    @override
    Widget build(BuildContext context) {
        _quizProvider = getIt.get<QuizProvider>();
        _question = _quizProvider.nextQuestion();
        return Scaffold(
            body: _buildBody()
        );
    }

    Widget _buildBody() {
        return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Align(alignment: Alignment.topCenter, child: _buildQuestionWidget(),),
                    Align(alignment: Alignment.bottomCenter, child: _buildAnswersListWidget(),)

                ],
            )
        );
    }

    Widget _buildQuestionWidget() {
        Symbol questionSymbol = _question.questionSymbol;
        Widget widget;
        switch (_question.questionField) {
            case SymbolField.FLAG: 
                widget = Image.asset(questionSymbol.imagePath, height: 100.0,);
                break;
            case SymbolField.NAME:
                widget = Text(questionSymbol.name, style: _nameTextStyle);
                break;
            case SymbolField.MEMO:
                widget = Text(questionSymbol.memo, style: _memoTextStyle);
                break;
        }
        return widget;
    }

    Widget _buildAnswersListWidget() {
        var children = <Widget>[];
        for (Symbol option in _question.options) {
            children.add(_buildAnswerWidget(option, _question.answersField));
        }

        var col = Column(
            children: children,
        );

        return col;
    }

    Widget _buildAnswerWidget(Symbol symbol, SymbolField answerField) {
        return ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
                child: Container(child:_buildAnswerButtonChild(symbol, answerField)),
                color: Colors.amber,
                onPressed: () {},
            ),
        );
    }

    Widget _buildAnswerButtonChild(Symbol symbol, SymbolField answerField) {
        Widget widget;
        switch (answerField) {
            case SymbolField.FLAG:
                widget = Image.asset(symbol.imagePath, height: 40.0,);
                break;
            case SymbolField.NAME:
                widget = Text(
                    symbol.name,
                    style: _buttonTextStyle,
                );
                break;
            case SymbolField.MEMO:
                widget = Text(
                    symbol.memo,
                    style: _buttonTextStyle,
                );
                break;
        }
        return widget;
    }
}
