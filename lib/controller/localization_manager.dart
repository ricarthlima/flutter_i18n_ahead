import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocalizationManager with ChangeNotifier {
  String languageCode;
  LocalizationManager(this.languageCode);

  static const String defaultLanguageCode = "en";

  Future<void> setLanguageCode(String newCode) async {
    languageCode = newCode;
    await _getLanguageFromServer(languageCode);
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

  Future<void> _getLanguageFromServer(String languageCode) async {
    String url =
        "https://gist.githubusercontent.com/ricarthlima/5f116fa4de01aa6cecc447986a1d3698/raw/c29ebe6768dadebede25751edcb3bdbbf439741d/app_$languageCode.json";

    http.Response httpResponse = await http.get(Uri.parse(url));
    Map<String, dynamic> response = json.decode(httpResponse.body);

    _mapLanguages[languageCode] = response.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  String get clearBooks => _getSentence("clearBooks");
  String get language => _getSentence("language");
  String get clear => _getSentence("clear");
}
