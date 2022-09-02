import 'dart:io';
import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/bottom_navigation_widget.dart';
import 'package:universe_history_app/widget/home_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        bottomNavigationBar: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: UiSize.bottomNavigation / 2),
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeaderWidget(),
                    ],
                  ),
                ),
              ),
            ),
            const BottomNavigationWidget(),
          ],
        ),
      ),
    );
  }
}
