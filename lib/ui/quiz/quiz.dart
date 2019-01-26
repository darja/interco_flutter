import 'package:flutter/material.dart';
import 'package:interco/main.dart';
import 'package:interco/model/question.dart';
import 'package:interco/model/symbol.dart';
import 'package:interco/services/QuizProvider.dart';
import 'package:interco/ui/quiz/quiz_button.dart';

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
                    Align(alignment: Alignment.bottomCenter,
                        child: QuizButtonGroupWidget(options: _question.options,
                            correctIndex: _question.correctIndex,
                            field: _question.answersField,
                        ),)

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
}
