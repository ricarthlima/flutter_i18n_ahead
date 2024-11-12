import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_i18n_ahead/controller/localization_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';

void main() {
  // Rodar aplicativo
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocalizationManager("en"),
      child: const Grimorio(),
    ),
  );
}

class Grimorio extends StatelessWidget {
  const Grimorio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meu Pequeno Grimório",
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pt', "BR"), // Brazilian Portuguese
        Locale('es'), // Spanish
      ],
      home: const SplashScreen(),
    );
  }
}
