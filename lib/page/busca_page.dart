import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscarPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.amber,
      ),
    );
  }
}
