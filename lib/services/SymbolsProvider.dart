import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import 'package:interco/model/symbol.dart';

class SymbolsProvider {
    List<Symbol> _symbols = List<Symbol>();

    Future<dynamic> init(AssetBundle assets) async {
        String fileContent = await assets.loadString("assets/symbols.yml");
        var doc = loadYamlDocument(fileContent);
        YamlMap root = doc.contents;
        YamlList nodes = root.nodes["symbols"];
        for (YamlMap node in nodes) {
            Symbol symbol = new Symbol(
                name: node["name"],
                memo: node["memo"]
            );
            _symbols.add(symbol);
        }
        debugPrint("Just loaded symbols: ${_symbols.length}");
    }

    List<Symbol> getSymbols() {
        return _symbols;
    }

    Symbol getSymbol(int index) {
        return _symbols[index];
    }
}