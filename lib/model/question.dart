import 'package:meta/meta.dart';
import 'package:interco/model/symbol.dart';

class Question {
    final List<Symbol> options;
    final int correctIndex;
    final SymbolField questionField;
    final SymbolField answersField;

    Question({
        @required this.options,
        @required this.correctIndex,
        @required this.questionField,
        @required this.answersField
    });

    Symbol get questionSymbol => options[correctIndex];
}
enum SymbolField { FLAG, NAME, MEMO }
