import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/localization_manager.dart';
import '../../dao/book_database.dart';
import '../../theme.dart';
import 'primary_button.dart';

Future<void> showSettingsDialog({
  required BuildContext context,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: ModalDecorationProperties.modalBorder,
        child: const _SettingsDialog(),
      );
    },
  );
}

class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog();

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  DisplayedLanguages _language = DisplayedLanguages.device;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Idioma", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<DisplayedLanguages>(
            value: _language,
            items: [
              const DropdownMenuItem(
                value: DisplayedLanguages.device,
                child: Row(
                  children: [
                    Icon(Icons.devices, size: 24),
                    SizedBox(width: 8),
                    Text("Padrão do Dispositivo"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: DisplayedLanguages.portuguese,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flags/portuguese.png",
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text("Português"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: DisplayedLanguages.english,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flags/english.png",
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text("English"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: DisplayedLanguages.spanish,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flags/spanish.png",
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text("Español"),
                  ],
                ),
              ),
            ],
            onChanged: (DisplayedLanguages? newLanguage) {
              if (newLanguage != null) {
                setState(() {
                  _language = newLanguage;
                });
                onChangedLanguage(newLanguage);
              }
            },
          ),
          const Text(
            "Limpar todos os livros",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          PrimaryButton(
            text: "Limpar",
            onTap: () {
              wipeBooks();
            },
          ),
        ],
      ),
    );
  }

  void wipeBooks() async {
    await PersonalBookDatabase().deleteAll();
    closeDialog();
  }

  void closeDialog() {
    Navigator.pop(context);
  }

  void onChangedLanguage(DisplayedLanguages language) {
    String newCode = "en";

    switch (language) {
      case DisplayedLanguages.device:
        newCode = Localizations.localeOf(context).languageCode;
        break;
      case DisplayedLanguages.portuguese:
        newCode = "pt";
        break;
      case DisplayedLanguages.english:
        newCode = "en";
        break;
      case DisplayedLanguages.spanish:
        newCode = "es";
        break;
    }

    context.read<LocalizationManager>().setLanguageCode(newCode);
  }
}

enum DisplayedLanguages { device, portuguese, english, spanish }
