import 'package:flutter/material.dart';

class EntrarPage extends StatefulWidget {
  const EntrarPage({super.key});

  @override
  State<EntrarPage> createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Text(
          'Whereas disregard and contempt for human rights have resulted',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
