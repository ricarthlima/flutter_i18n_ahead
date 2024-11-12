import 'package:flutter/material.dart';

class LocalizationManager with ChangeNotifier {
  String languageCode;
  LocalizationManager(this.languageCode);

  static const String defaultLanguageCode = "en";

  setLanguageCode(String newCode) {
    languageCode = newCode;
    notifyListeners();
  }

  // No futuro esse map tem que se preencher automagicamente
  final Map<String, Map<String, String>> _mapLanguages = {
    "pt": {
      "clearBooks": "Limpar todos os livros",
      "language": "Idioma",
      "clear": "Limpar",
    },
    "es": {
      "clearBooks": "Eliminar todos los libros",
      "language": "Idioma",
      "clear": "Limpiar",
    },
    "en": {
      "clearBooks": "Clear all books",
      "language": "Language",
      "clear": "Clear",
    },
  };

  String _getSentence(String keySentence) {
    String? sentence = _mapLanguages[languageCode]![keySentence];

    sentence ??= _mapLanguages[defaultLanguageCode]![keySentence]!;

    return sentence;
  }

  String get clearBooks => _getSentence("clearBooks");
  String get language => _getSentence("language");
  String get clear => _getSentence("clear");
}
