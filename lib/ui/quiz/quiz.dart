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
    bool _answerHighlighted = false;
    int _selectedOptionIndex = -1;

    static const _nameQuestionTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0);
    static const _memoQuestionTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);

    static const _nameAnswerTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0);
    static const _memoAnswerTextStyle = TextStyle(fontSize: 16.0);

    @override
    void initState() {
        super.initState();
        _quizProvider = getIt.get<QuizProvider>();
        _question = _quizProvider.nextQuestion();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: _buildBody()
        );
    }

    Widget _buildBody() {
        debugPrint("buildBody");
        return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Align(alignment: Alignment.topCenter, child: _buildQuestionWidget(),),
                    Align(alignment: Alignment.bottomCenter,
                        child: QuizButtonGroupWidget(
                            itemsCount: _question.options.length,
                            itemBuilder: _buildAnswerButtonContent,
                            answerHighlighter: _answerHighlighter,
                            onAnswerSelected: (index) => onAnswerSelected(index)
                        ),)

                ],
            )
        );
    }

    onAnswerSelected(int index) {
        setState(() {
            _selectedOptionIndex = index;
            _answerHighlighted = true;
        });

        Future.delayed(Duration(seconds: 2), () {
            setState(() {
                _selectedOptionIndex = -1;
                _answerHighlighted = false;
                _question = _quizProvider.nextQuestion();
            });
        });
    }

    Widget _buildQuestionWidget() {
        Symbol questionSymbol = _question.questionSymbol;
        Widget widget;
        switch (_question.questionField) {
            case SymbolField.FLAG: 
                widget = Image.asset(questionSymbol.imagePath, height: 100.0,);
                break;
            case SymbolField.NAME:
                widget = Text(questionSymbol.name, style: _nameQuestionTextStyle);
                break;
            case SymbolField.MEMO:
                widget = Text(questionSymbol.memo, style: _memoQuestionTextStyle);
                break;
        }
        return widget;
    }

    _buildAnswerButtonContent(int i) {
        var symbol = _question.options[i];
        switch (_question.answersField) {
            case SymbolField.FLAG:
                return Image.asset(symbol.imagePath, height: 50.0,);
            case SymbolField.NAME:
                return Text(
                    symbol.name,
                    style: _nameAnswerTextStyle,
                );
            case SymbolField.MEMO:
                return Text(
                    symbol.memo,
                    style: _memoAnswerTextStyle,
                );
        }
    }

    _answerHighlighter(int i) {
        if (_answerHighlighted) {
            if (i == _question.correctIndex) {
                return Colors.green;
            } else if (i == _selectedOptionIndex) {
                return Colors.red;
            }
        }
        return Colors.amber;
    }
}
