// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, unused_element, curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:universe_history_app/components/card_component.dart';
import 'package:universe_history_app/components/history_list_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/menu_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  bool _notification = true;
  String _itemSelectedMenu = 'todas';

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  void _selectMenu(value) {
    setState(() {
      _itemSelectedMenu = value;
    });
  }

  bool _showCard(String? category) {
    return category == 'todas' || category == 'minhas' ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: uiColor.first,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: uiColor.comp_1,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: ScrollAppBar(
          backgroundColor: uiColor.first,
          controller: _scrollController,
          automaticallyImplyLeading: false,
          toolbarHeight: 48,
          elevation: 0,
          titleSpacing: 10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LogoComponent(
                color: uiColor.icon_2,
                size: 20,
                callback: (value) => _scrollToTop(),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      IconComponent(
                        icon: uiSvg.notification,
                        color: uiColor.icon_2,
                        route: 'notification',
                      ),
                      if (_notification)
                        Positioned(
                          top: 10,
                          right: 12,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: uiColor.warning,
                          ),
                        ),
                    ],
                  ),
                  IconComponent(
                    icon: uiSvg.options,
                    color: uiColor.icon_2,
                    route: 'settings',
                  ),
                ],
              )
            ],
          ),
        ),
        body: Snap(
          controller: _scrollController.appBar,
          child: Container(
            color: uiColor.comp_1,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MenuComponent(),
                  SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: menuItemSelected,
                    builder: (BuildContext context, value, __) {
                      return Container(
                        child: _showCard(menuItemSelected.value.id)
                            ? SizedBox()
                            : Container(
                                child: ValueListenableBuilder(
                                  valueListenable: currentUser,
                                  builder: (context, value, __) {
                                    return value != null
                                        ? CardComponent(
                                            title: 'Escreva sua história',
                                            text:
                                                'Todos nós temos uma história pra contar e a sua pode ajudar alguém.',
                                            label: 'Escrever',
                                            callback: (valeu) =>
                                                Navigator.of(context)
                                                    .pushNamed("/create"),
                                          )
                                        : CardComponent(
                                            title: 'Entre ou crie sua conta',
                                            text:
                                                'Você não se identificou ainda para escrever histórias e comentarios.',
                                            label: 'Entrar',
                                            callback: (valeu) =>
                                                Navigator.of(context)
                                                    .pushNamed("/login"),
                                          );
                                  },
                                ),
                              ),
                      );
                    },
                  ),
                  Flexible(
                    child: HistoryListComponent(
                        itemSelectedMenu: _itemSelectedMenu),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
