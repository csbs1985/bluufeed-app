import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/comment_service.dart';
import 'package:bluuffed_app/service/date_service.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/service/name_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/widget/dialog_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _formKey = GlobalKey<FormState>();

  final ActivityClass activityClass = ActivityClass();
  final CommentService commentService = CommentService();
  final DateService dateService = DateService();
  final HistoryService historyService = HistoryService();
  final NameClass _nameClass = NameClass();
  final TextEditingController _nameController = TextEditingController();
  final ToastWidget toastWidget = ToastWidget();

  final int _rulesDays = 30;
  final String _currentName = currentUser.value.first.name;

  int _daysRemaining = 0;
  bool _cantChange = true;

  @override
  void initState() {
    _nameController.text = currentUser.value.first.name;
    _validateupDateName();
    super.initState();
  }

  _validateupDateName() {
    setState(() {
      _daysRemaining = dateService.qtyDays(currentUser.value.first.upDateName);
      _cantChange = _daysRemaining < _rulesDays ? true : false;
    });
  }

  _nameChange(BuildContext context) {
    if (_currentName != _nameController.text) {
      currentDialog.value = 'vamos com calma, uma coisa de cada vez...';

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const DialogWidget();
        },
      );

      try {
        String _now;
        _nameClass.getName(_nameController.text).then((result) => {
              if (result)
                toastWidget.toast(
                  context,
                  ToastEnum.WARNING.value,
                  'nome de usuário indisponivél',
                )
              else
                {
                  _now = DateTime.now().toString(),
                  _nameClass.nameChange(_nameController.text, _now),
                  currentUser.value.first.name = _nameController.text,
                  currentUser.value.first.upDateName = _now,
                  currentDialog.value =
                      'alterando nome de usuário nas histórias...',
                  historyService.pathAllHistory(),
                  currentDialog.value =
                      'alterando nome de usuário nos comentários...',
                  commentService.pathAllComment(),
                  activityClass.save(
                    type: ActivityEnum.UP_NICKNAME.value,
                    content: _nameController.text,
                    elementId: _currentName,
                  ),
                  toastWidget.toast(
                    context,
                    ToastEnum.SUCCESS.value,
                    'nome de usuário alterado',
                  ),
                  Navigator.pop(context),
                  Navigator.pop(context),
                }
            });
      } on FirebaseAuthException catch (error) {
        debugPrint('ERROR => _nameChange: $error');
      }
    } else {
      toastWidget.toast(
        context,
        ToastEnum.WARNING.value,
        'este é seu nome de usuário atual',
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBackWidget(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            0,
            UiPadding.large,
            UiPadding.large,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Headline1(title: 'Nome de usuário'),
                const TextWidget(
                  text:
                      'Os nomes de usuário só podem usar letras, números, sublinhados e pontos, deve ser único e de 6 à 20 caracteres.'
                      '\n'
                      'Você só poderá alterar depois de 30 (trinta) dias.',
                ),
                if (_cantChange) const SizedBox(height: UiPadding.large),
                if (_cantChange)
                  TextWidget(
                    text:
                        'espere mais ${_rulesDays - _daysRemaining} dia(s) para alterar o nome de usuário.',
                  ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  enabled: !_cantChange,
                  controller: _nameController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  validator: (value) => _nameClass.validateName(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: 'usuário',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: UiPadding.large),
                if (!_cantChange)
                  Button3dWidget(
                    callback: (value) => _nameChange(context),
                    label: 'alterar',
                    style: ButtonStyleEnum.PRIMARY.value,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
