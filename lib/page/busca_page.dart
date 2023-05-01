import 'package:bluufeed_app/appbar/simples_appbar.dart';
import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimplesAppbar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
        ),
      ),
    );
  }
}
