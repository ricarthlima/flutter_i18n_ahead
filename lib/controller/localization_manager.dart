import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_i18n_ahead/utils/prefs_keys.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationManager with ChangeNotifier {
  String languageCode;
  LocalizationManager(this.languageCode);

  static const String defaultLanguageCode = "en";

  // No futuro esse map tem que se preencher automagicamente
  final Map<String, Map<String, String>> _mapLanguages = {};

  Future<void> setLanguageCode(String newCode) async {
    await _getLanguageFromServer(newCode);
    languageCode = newCode;
    _saveLanguageCode(languageCode);
    notifyListeners();
  }

  Future<void> _saveLanguageCode(String newCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefsKeys.language, newCode);
  }

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
