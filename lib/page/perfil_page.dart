import 'package:bluuffed_app/widget/app_bar_not_back_widget.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNotBackWidget(title: 'Perfil'),
      body: Container(),
    );
  }
}
