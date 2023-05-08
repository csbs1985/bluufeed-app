import 'package:flutter/material.dart';

class ConfiguracaoDrawer extends StatefulWidget {
  const ConfiguracaoDrawer({super.key});

  @override
  State<ConfiguracaoDrawer> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<ConfiguracaoDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: const SingleChildScrollView(),
    );
  }
}
