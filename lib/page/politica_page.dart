import 'package:eight_app/appbar/voltar_appbar.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class PoliticaPage extends StatefulWidget {
  const PoliticaPage({super.key});

  @override
  State<PoliticaPage> createState() => _PoliticaPageState();
}

class _PoliticaPageState extends State<PoliticaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 19, 16),
        child: SingleChildScrollView(
          child: StyledText(
            text: POLITICA_PRIVACIDADE,
            style: Theme.of(context).textTheme.displayMedium,
            softWrap: true,
            overflow: TextOverflow.clip,
            tags: {
              'bold': StyledTextTag(
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            },
          ),
        ),
      ),
    );
  }
}
