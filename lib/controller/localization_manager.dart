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
    },
    "es": {
      "clearBooks": "Eliminar todos los libros",
    },
    "en": {
      "clearBooks": "Clear all books",
    },
  };

  String _getSentence(String keySentence) {
    String? sentence = _mapLanguages[languageCode]![keySentence];

    sentence ??= _mapLanguages[defaultLanguageCode]![keySentence]!;

    return sentence;
  }

  String get clearBooks => _getSentence("clearBooks");
}
