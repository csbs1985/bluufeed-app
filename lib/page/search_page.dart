import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/model/notification_model.dart';
import 'package:bluuffed_app/model/search_model.dart';
import 'package:bluuffed_app/model/user_recent_model.dart';
import 'package:bluuffed_app/service/algolia_service.dart';
import 'package:bluuffed_app/service/user_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/search_history_widget.dart';
import 'package:bluuffed_app/widget/search_menu_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:bluuffed_app/widget/user_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final NotificationClass notificationClass = NotificationClass();
  final TextEditingController _valueController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserRecentClass userRecentClass = UserRecentClass();
  final UserService userService = UserService();
  final Uuid uuid = const Uuid();

  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot>? _snapshotHistory;
  List<AlgoliaObjectSnapshot>? _snapshotUser;

  bool isInputEmpty = true;

  String _searchMenu = SearchMenuEnum.HISTORY.value;

  @override
  initState() {
    algolia = AlgoliaService.algolia;
    super.initState();
  }

  void keyUp() {
    setState(() {
      isInputEmpty = _valueController.text.isEmpty ? true : false;
    });

    _searchHistory();
    _searchUser();
  }

  _searchHistory() async {
    AlgoliaQuery _queryHistory = algolia!.instance
        .index('bluufeed_stories')
        .query(_valueController.text);

    AlgoliaQuerySnapshot _snapHistory = await _queryHistory.getObjects();

    if (_snapHistory.hits.isNotEmpty)
      setState(() => _snapshotHistory = _snapHistory.hits);

    if (_valueController.text.isEmpty) _snapshotHistory = null;
  }

  _searchUser() async {
    AlgoliaQuery _queryUser =
        algolia!.instance.index('bluufeed_users').query(_valueController.text);

    AlgoliaQuerySnapshot _snapUser = await _queryUser.getObjects();

    if (_snapUser.hits.isNotEmpty)
      setState(() => _snapshotUser = _snapUser.hits);

    if (_valueController.text.isEmpty) _snapshotUser = null;
  }

  _menuCallback(String value) {
    setState(() => _searchMenu = value);
  }

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
          bool isDark = currentTheme.value == Brightness.dark;

          return Material(
            color: isDark ? UiColor.mainDark : UiColor.main,
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
                        TextField(
                          autofocus: false,
                          controller: _valueController,
                          onChanged: (value) => keyUp(),
                          style: Theme.of(context).textTheme.headline2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: UiPadding.large,
                              vertical: UiPadding.small,
                            ),
                            hintText: 'pesquisar',
                            hintStyle: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: UiPadding.large),
                  _valueController.text.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: UiPadding.large,
                          ),
                          child: Headline2(
                            text:
                                'Pesquise pelo nome de usuário, título ou texto da história',
                          ),
                        )
                      : Column(
                          children: [
                            SearchMenuWidget(
                              init: _searchMenu,
                              callback: (value) => _menuCallback(value),
                            ),
                            if (_searchMenu == SearchMenuEnum.HISTORY.value)
                              SearchHistoryWidget(snapshot: _snapshotHistory),
                            if (_searchMenu == SearchMenuEnum.USER.value)
                              UserItemWidget(
                                content:
                                    userService.algoliaToList(_snapshotUser!),
                              ),
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
}
