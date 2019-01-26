import 'package:meta/meta.dart';
class Symbol {
    final String name;
    final String memo;

    Symbol({
        @required this.name,
        @required this.memo
    });

    String getImagePath() {
        return "assets/flags/${name.toLowerCase()}.png";
    }
}