import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/model/user_recent_model.dart';
import 'package:universe_history_app/service/algolia_service.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/button_publish_widget.dart';
import 'package:universe_history_app/widget/subtitle_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class SendModal extends StatefulWidget {
  const SendModal({super.key});

  @override
  State<SendModal> createState() => _SendModalState();
}

class _SendModalState extends State<SendModal> {
  final TextEditingController _commentController = TextEditingController();
  final UserClass userClass = UserClass();

  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot>? _snapshot;

  bool isInputEmpty = true;

  @override
  initState() {
    algolia = AlgoliaService.algolia;
    super.initState();
  }

  Future<void> keyUp() async {
    if (_commentController.text == " ") Navigator.of(context).pop();

    setState(() {
      isInputEmpty = _commentController.text.isEmpty ? true : false;
    });

    AlgoliaQuery _query =
        algolia!.instance.index('history_users').query(_commentController.text);

    AlgoliaQuerySnapshot _snap = await _query.getObjects();

    if (_snap.hits.isNotEmpty) setState(() => _snapshot = _snap.hits);
    if (_commentController.text.isEmpty) _snapshot = null;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Material(
          color: isDark ? UiColor.mainDark : UiColor.main,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                height: UiSize.appBar,
                padding:
                    const EdgeInsets.symmetric(horizontal: UiPadding.large),
                child: const TextWidget(text: 'Compartilhar história'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  UiPadding.large,
                  0,
                  UiPadding.large,
                  UiPadding.small,
                ),
                child: TextField(
                  controller: _commentController,
                  onChanged: (value) => keyUp(),
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: 'pesquisar usuário',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(UiPadding.large),
                child: isInputEmpty
                    ? _userRecent()
                    : Column(
                        children: [
                          const SubtitleWidget(resume: 'pesquisando'),
                          _snapshot == null
                              ? _notResult()
                              : _algolia(_snapshot),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userRecent() {
    return Column(
      children: [
        const SubtitleWidget(resume: 'recente'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(text: 'name'),
            ButtonPublishWidget(
              label: 'enviar',
              callback: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _notResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: UiSize.bottomLarge,
          child: const TextWidget(text: 'usuário não encontrado'),
        ),
      ],
    );
  }

  Widget _algolia(_snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: _snapshot!.length,
      itemBuilder: (BuildContext context, int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: _snapshot![index].data['name']),
          ButtonPublishWidget(
            label: 'enviar',
            callback: () {},
          ),
        ],
      ),
    );
  }
}
