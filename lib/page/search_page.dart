import 'package:bluuffed_app/widget/app_bar_not_back_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNotBackWidget(title: 'Busca'),
      body: Container(),
    );
  }
}
