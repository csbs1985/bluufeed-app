import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/button/button_publish_widget.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/notification_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/model/user_recent_model.dart';
import 'package:bluuffed_app/service/algolia_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/subtitle_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final Uuid uuid = const Uuid();

  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot>? _snapshot;

  bool isInputEmpty = true;

  late Map<String, dynamic> _form;
  late Map<String, dynamic> _currentRecent;

  @override
  initState() {
    algolia = AlgoliaService.algolia;
    super.initState();
  }

  Future<void> keyUp() async {
    if (_valueController.text == " ") Navigator.of(context).pop();

    setState(() {
      isInputEmpty = _valueController.text.isEmpty ? true : false;
    });

    AlgoliaQuery _query =
        algolia!.instance.index('history_users').query(_valueController.text);

    AlgoliaQuerySnapshot _snap = await _query.getObjects();

    if (_snap.hits.isNotEmpty) setState(() => _snapshot = _snap.hits);
    if (_valueController.text.isEmpty) _snapshot = null;
  }

  _formatAlgolia(_user) {
    _currentRecent = {
      'id': _user.data['objectID'],
      'name': _user.data['name'],
    };

    _postSend(_currentRecent);
  }

  _formatRecent(_user) {
    _currentRecent = {
      'id': _user.id,
      'name': _user.name,
    };

    _postSend(_currentRecent);
  }

  _postSend(_user) {
    userRecentClass.add(_currentRecent);

    try {
      _form = {
        'content': '',
        'date': DateTime.now().toString(),
        'id': uuid.v4(),
        'contentId': currentHistory.value.first.id,
        'userId': _user['id'] ?? _user.data['objectID'],
        'userName': currentUser.value.first.name,
        'status': NotificationEnum.SEND_HISTORY.value,
        'view': false,
      };

      notificationClass.postNotification(context, _form);
      notificationClass.setNotificationSendHistory(context, _form);

      toast.toast(
        context,
        ToastEnum.SUCCESS.value,
        'história compartilhada',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => _postSend: ' + error.toString());
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        'não foi possivél compartilhar história',
      );
    }
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
              child: Container(
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
                    const SizedBox(height: UiPadding.large),
                    SingleChildScrollView(
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _userRecent() {
    return ValueListenableBuilder(
      valueListenable: currentUserRecent,
      builder: (BuildContext context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubtitleWidget(resume: 'recente'),
            const SizedBox(height: UiPadding.medium),
            currentUserRecent.value.isEmpty
                ? const TextWidget(text: 'você não compartilhou história ainda')
                : ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: currentUserRecent.value.length,
                    itemBuilder: (BuildContext context, int index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: currentUserRecent.value[index].name),
                        ButtonPublishWidget(
                          label: 'enviar',
                          callback: (value) =>
                              _formatRecent(currentUserRecent.value[index]),
                        ),
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _notResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: UiSize.bottom,
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
            callback: (value) => _formatAlgolia(_snapshot![index]),
          ),
        ],
      ),
    );
  }
}
