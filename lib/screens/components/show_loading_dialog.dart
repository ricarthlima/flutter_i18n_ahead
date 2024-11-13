import 'package:flutter/material.dart';

Future<void> showLoadingDialog(
  BuildContext context,
  Future futureTask,
) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Impede o fechamento ao clicar fora do diálogo
    builder: (context) {
      futureTask.then((value) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
      return const Dialog(
        backgroundColor: Colors.transparent, // Fundo transparente
        insetPadding: EdgeInsets.zero, // Preenche a tela toda
        child: Center(
          child: CircularProgressIndicator(), // Indicador de carregamento
        ),
      );
    },
  );
}
