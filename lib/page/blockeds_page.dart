import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';

class BlockedsPage extends StatefulWidget {
  const BlockedsPage({super.key});

  @override
  State<BlockedsPage> createState() => _BlockedsPageState();
}

class _BlockedsPageState extends State<BlockedsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: UiPadding.large),
              child: Headline1(title: 'Usuários bloqueados'),
            ),
          ],
        ),
      ),
    );
  }
}
