import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/model/activity_model.dart';
import 'package:universe_history_app/widget/app_bar_not_back_widget.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/select_category_widget.dart';
import 'package:universe_history_app/widget/select_toggle_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';
import 'package:uuid/uuid.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  final ActivityClass activityClass = ActivityClass();
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();
  final Uuid uuid = const Uuid();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _categories = [];

  bool _isEdit = false;
  bool _isSigned = true;
  bool _isComment = true;
  bool _btnPublish = false;
  bool _isAuthorized = false;

  late Map<String, dynamic> _history;
  late Map<String, dynamic> activity;

  @override
  void initState() {
    if (currentHistory.value.isNotEmpty) {
      titleController.text = currentHistory.value.first.title;
      textController.text = currentHistory.value.first.text;
      _isEdit = true;
      _btnPublish = true;
      _isSigned = currentHistory.value.first.isSigned;
      _isComment = currentHistory.value.first.isComment;
      _isAuthorized = currentHistory.value.first.isAuthorized;
      _categories = currentHistory.value.first.categories;
    }

    super.initState();
  }

  void _setPrivacy() {
    setState(() {
      _isSigned = !_isSigned;
      _canPublish();
    });
  }

  void _setComment() {
    setState(() {
      _isComment = !_isComment;
      _canPublish();
    });
  }

  void _setAuthorized() {
    setState(() {
      _isAuthorized = !_isAuthorized;
      _canPublish();
    });
  }

  void _setCategories(List<String> value) {
    setState(() {
      _categories = value;
      _canPublish();
    });
  }

  void _canPublish() {
    setState(() {
      _btnPublish = (textController.text.isNotEmpty && _categories.isNotEmpty)
          ? true
          : false;
    });
  }

  Future<void> _postHistory(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      if (currentHistory.value.isNotEmpty) {
        _history = {
          'id': currentHistory.value.first.id,
          'title': titleController.text.trim(),
          'text': textController.text.trim(),
          'date': currentHistory.value.first.date,
          'isComment': _isComment,
          'isSigned': _isSigned,
          'isEdit': true,
          'isAuthorized': _isAuthorized,
          'qtyComment': currentHistory.value.first.qtyComment,
          'categories': _categories,
          'userId': currentUser.value.first.id,
          'userName': currentUser.value.first.name,
          'bookmarks': currentHistory.value.first.bookmarks,
        };
      } else {
        _history = {
          'id': uuid.v4(),
          'title': titleController.text.trim(),
          'text': textController.text.trim(),
          'date': DateTime.now().toString(),
          'isComment': _isComment,
          'isSigned': _isSigned,
          'isEdit': false,
          'isAuthorized': _isAuthorized,
          'qtyComment': 0,
          'categories': _categories,
          'userId': currentUser.value.first.id,
          'userName': currentUser.value.first.name,
          'bookmarks': [],
        };
      }
    });

    try {
      await historiesFirestore.postHistory(_history);
      _pathQtyHistoryUser();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewHistory:$error');
      toast.toast(context, ToastEnum.WARNING.value,
          'Erro ao publicar história, tente novamente mais tarde.');
    }
  }

  Future<void> _pathQtyHistoryUser() async {
    if (!_isEdit) currentUser.value.first.qtyHistory++;

    try {
      await userFirestore.pathQtyHistoryUser(currentUser.value.first);
      // activityClass.save(
      //   _isEdit
      //       ? ActivityEnum.NEW_HISTORY.value
      //       : ActivityEnum.UP_HISTORY.value,
      //   titleController.text,
      //   _history['id'],
      // );
      if (currentHistory.value.isNotEmpty) Navigator.of(context).pop();
      toast.toast(
        context,
        ToastEnum.SUCCESS.value,
        _isEdit ? 'História foi alterada!' : 'História  publicada!',
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => pathQtyHistoryUser:$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Scaffold(
          key: scaffoldKey,
          appBar: const AppBarNotBackWidget(title: 'Escrever'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                UiPadding.large,
                0,
                UiPadding.large,
                UiPadding.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 60,
                    style: Theme.of(context).textTheme.headline1,
                    onChanged: (value) => _canPublish(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      counterText: "",
                      fillColor: isDark ? UiColor.mainDark : UiColor.main,
                      hintText: 'Título',
                      hintStyle: Theme.of(context).textTheme.headline1,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                  TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    style: Theme.of(context).textTheme.headline2,
                    onChanged: (value) => _canPublish(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: isDark ? UiColor.mainDark : UiColor.main,
                      hintText: 'História',
                      hintStyle: Theme.of(context).textTheme.headline2,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: UiPadding.xLarge),
                  SelectToggleWidget(
                    title: 'Assinatura',
                    resume:
                        'Ligado para assinar como ${currentUser.value.first.name} ou desligado para anônimo.',
                    value: _isSigned,
                    callback: (value) => _setPrivacy(),
                  ),
                  const SizedBox(height: UiPadding.xLarge),
                  SelectToggleWidget(
                    title: 'Comentários',
                    resume:
                        'Ligado para habilitar ou desligado para desabilitar os comentários na história.',
                    value: _isComment,
                    callback: (value) => _setComment(),
                  ),
                  const SizedBox(height: UiPadding.xLarge),
                  SelectToggleWidget(
                    title: 'Autorizado',
                    resume:
                        'Ligado para marcar história como de terceiro com autorização para publicar.',
                    value: _isAuthorized,
                    callback: (value) => _setAuthorized(),
                  ),
                  const SizedBox(height: UiPadding.xLarge),
                  SelectCategoriesWidget(
                    selected: currentHistory.value.isNotEmpty
                        ? currentHistory.value.first.categories
                        : [],
                    callback: (value) => _setCategories(value),
                  ),
                  const SizedBox(height: UiPadding.xLarge),
                  Button3dWidget(
                    callback: () => _postHistory,
                    label: 'publicar',
                    style: _btnPublish
                        ? ButtonStyleEnum.PRIMARY.value
                        : ButtonStyleEnum.DISABLED.value,
                    size: ButtonSizeEnum.LARGE.value,
                    padding: UiPadding.large * 2,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
