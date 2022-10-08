import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/model/notification_model.dart';
import 'package:bluuffed_app/model/user_recent_model.dart';
import 'package:bluuffed_app/service/algolia_service.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/search_date_widget.dart';
import 'package:bluuffed_app/widget/subtitle_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/title_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final HistoryService historyService = HistoryService();
  final NotificationClass notificationClass = NotificationClass();
  final TextEditingController _valueController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserRecentClass userRecentClass = UserRecentClass();
  final Uuid uuid = const Uuid();

  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot>? _snapshot;

  bool isInputEmpty = true;

  bool? isDark;

  @override
  initState() {
    algolia = AlgoliaService.algolia;
    super.initState();
  }

  Future<void> keyUp() async {
    setState(() {
      isInputEmpty = _valueController.text.isEmpty ? true : false;
    });

    AlgoliaQuery _query = algolia!.instance
        .index('bluufeed_stories')
        .query(_valueController.text);

    AlgoliaQuerySnapshot _snap = await _query.getObjects();

    if (_snap.hits.isNotEmpty) setState(() => _snapshot = _snap.hits);

    if (_valueController.text.isEmpty) _snapshot = null;
  }

  _getHistory(String _historyId) {}

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
      body: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          isDark = currentTheme.value == Brightness.dark;

          return Material(
            color: isDark! ? UiColor.mainDark : UiColor.main,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: UiPadding.large),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Headline1(title: 'Pesquisar'),
                        const TextWidget(
                          text: 'Pesquise pelo usuário ou o título da história',
                        ),
                        const SizedBox(height: UiPadding.medium),
                        TextField(
                          controller: _valueController,
                          onChanged: (value) => keyUp(),
                          style: Theme.of(context).textTheme.headline2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: UiPadding.large,
                              vertical: UiPadding.small,
                            ),
                            hintText: 'pesquisar ',
                            hintStyle: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: UiPadding.large),
                  Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: UiPadding.large),
                        child: SubtitleWidget(resume: 'histórias'),
                      ),
                      _snapshot == null
                          ? _notResult()
                          : _algoliaHistory(_snapshot),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _algoliaHistory(_snapshot) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: _snapshot!.length,
      itemBuilder: (BuildContext context, int index) => TextButton(
        onPressed: () =>
            historyService.getHistoryPage(_snapshot![index].data['objectID']),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: isDark! ? UiColor.mainDark : UiColor.main,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiBorder.none),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UiPadding.large,
                vertical: UiPadding.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(title: _snapshot![index].data['title']),
                  SearchDateWidget(item: _snapshot![index].data),
                  const SizedBox(height: UiPadding.medium),
                  TextWidget(text: _snapshot![index].data['text']),
                  const SizedBox(height: UiPadding.large),
                ],
              ),
            ),
            const BorderWidget(),
          ],
        ),
      ),
    );
  }

  Widget _notResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: UiSize.bottom,
            child: const TextWidget(
              text: 'não encontramos histórias para sua pesquisa',
            ),
          ),
        ],
      ),
    );
  }
}
