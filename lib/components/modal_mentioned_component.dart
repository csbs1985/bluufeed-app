// ignore_for_file: prefer_is_empty, unused_field, void_checks, avoid_print, unnecessary_new, use_key_in_widget_constructors, curly_braces_in_flow_control_structures, import_of_legacy_library_into_null_safe, unused_element, unnecessary_null_comparison

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/core/algolia.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ModalMentionedComponent extends StatefulWidget {
  const ModalMentionedComponent({required Function callback})
      : _callback = callback;

  final Function _callback;

  @override
  _ModalMentionedComponentState createState() =>
      _ModalMentionedComponentState();
}

class _ModalMentionedComponentState extends State<ModalMentionedComponent> {
  final TextEditingController _commentController = TextEditingController();

  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot>? _snapshot;

  @override
  initState() {
    algolia = Aplication.algolia;
    super.initState();
  }

  Future<void> keyUp() async {
    AlgoliaQuery _query =
        algolia!.instance.index('history_users').query(_commentController.text);

    AlgoliaQuerySnapshot _snap = await _query.getObjects();
    setState(() => _snapshot = _snap.hits);

    if (_commentController.text.isEmpty) {
      _snapshot = null;
    }
  }

  void _setUser(_user) {
    setState(() {
      widget._callback(_user);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: _snapshot == null
                      ? _noResult()
                      : ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: _snapshot!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 48,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: TextButton(
                                    child: Text(
                                        '@' +
                                            _snapshot![index].data['nickname'],
                                        style: uiTextStyle.buttonSecondLabel),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              uiColor.buttonSecond),
                                    ),
                                    onPressed: () =>
                                        _setUser(_snapshot![index].data),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const DividerComponent(bottom: 0),
                Container(
                  height: uiSize.input,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Center(
                    child: TextField(
                      controller: _commentController,
                      onChanged: (value) => keyUp(),
                      autofocus: true,
                      maxLines: null,
                      style: uiTextStyle.text1,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Mencionar usuário...",
                          hintStyle: uiTextStyle.text7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text:
            'Nenhum usuário encontrado ou você digitou o email ou usuário errado.');
  }
}
