import 'dart:collection';
import 'dart:math';
import 'package:meta/meta.dart';

import 'package:interco/model/question.dart';
import 'package:interco/model/symbol.dart';

class QuizProvider {
    static const int HISTORY_SIZE = 5;
    static const int OPTIONS_COUNT = 4;

    Queue<int> history = Queue<int>();
    List<Symbol> _symbols = List<Symbol>();
    int _symbolsCount;
    Random _random;

    QuizProvider({@required symbols}) {
        _symbols = symbols;
        _symbolsCount = _symbols.length;
        _random = Random(DateTime.now().millisecondsSinceEpoch);
    }

    Question nextQuestion() {
        // correct answer
        int correctSymbolIndex = -1;
        do {
            correctSymbolIndex = _random.nextInt(_symbolsCount);
        } while (history.contains(correctSymbolIndex));

        // options
        var optionsIndices = [];
        while (optionsIndices.length < OPTIONS_COUNT - 1) {
            var index = _random.nextInt(_symbolsCount);
            if (!optionsIndices.contains(index) && index != correctSymbolIndex) {
                optionsIndices.add(index);
            }
        }

        // save correct answer to history to prevent its appearance for several upcoming questions
        history.add(correctSymbolIndex);
        while (history.length > HISTORY_SIZE) {
            history.removeFirst();
        }

        // inserting correct option in random place in options
        var correctOptionIndex = _random.nextInt(OPTIONS_COUNT);
        optionsIndices.insert(correctOptionIndex, correctSymbolIndex);

        // pick question and answer fields
        var questionField = _pickRandomSymbolField();
        var answersField = _pickCompatibleSymbolField(questionField);

        return Question(
            options: optionsIndices.map((it) => _symbols[it]).toList(),
            correctIndex: correctOptionIndex,
            questionField: questionField,
            answersField: answersField
        );
    }

    SymbolField _pickRandomSymbolField() {
        var values = SymbolField.values;
        return values[_random.nextInt(values.length)];
    }

    SymbolField _pickCompatibleSymbolField(SymbolField field) {
        SymbolField partner;
        do {
            partner = _pickRandomSymbolField();
        } while (!_areSymbolFieldsCompatible(field, partner));
        return partner;
    }

    bool _areSymbolFieldsCompatible(SymbolField f1, SymbolField f2) {
        return f1 != f2 &&
            !(f1 == SymbolField.NAME && f2 == SymbolField.MEMO ||
            f2 == SymbolField.NAME && f1 == SymbolField.MEMO);
    }
}