import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_card_widget.dart';
import 'package:bluuffed_app/firestore/denounce_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/denounce_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DenouncePage extends StatefulWidget {
  const DenouncePage({super.key});

  @override
  State<DenouncePage> createState() => _DenouncePageState();
}

class _DenouncePageState extends State<DenouncePage> {
  final ActivityClass activityClass = ActivityClass();
  final DenounceFirestore denounceFirestore = DenounceFirestore();
  final ToastWidget toastWidget = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();
  final Uuid uuid = const Uuid();

  final List<DenounceJustifyModel> _allDenounceJustify =
      DenounceJustifyModel.allDenounceJustify;

  bool _hasButton = false;

  Map<String, dynamic>? _user;
  late Map<String, dynamic> _form;

  late DenounceJustifyModel justifySelected;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  _getUser() async {
    try {
      await userFirestore.getUserId(currentUserId.value).then((result) => {
            _user = {
              'id': result.docs[0]['id'],
              'date': result.docs[0]['date'],
              'name': result.docs[0]['name'],
              'upDateName': result.docs[0]['upDateName'],
              'status': result.docs[0]['status'],
              'email': result.docs[0]['email'],
              'token': result.docs[0]['token'],
              'isNotification': result.docs[0]['isNotification'],
              'qtyHistory': result.docs[0]['qtyHistory'],
              'qtyComment': result.docs[0]['qtyComment'],
            },
          });
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postDenounce: ' + error.toString());
    }
  }

  void _selected(DenounceJustifyModel item) {
    setState(() {
      _hasButton = true;
      justifySelected = item;
    });
  }

  Future<void> _postDenounce(bool value) async {
    _form = {
      'id': uuid.v4(),
      'userId': _user!['id'],
      'idDenounced': currentUser.value.first.id,
      'nickDenounced': _user!['name'],
      'code': justifySelected.id,
      'justify': justifySelected.title,
      'date': DateTime.now().toString(),
    };

    try {
      await denounceFirestore.postDenounce(_form);
      Navigator.of(context).pop();
      activityClass.save(
        type: ActivityEnum.DENOUNCE.value,
        content: _user!['name'],
        elementId: _form['date'],
      );
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'Usuário ${_user!['name']} denunciado!',
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postDenounce: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBackWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headline1(title: "Denunciar ${_user?['name']}"),
              const TextWidget(
                text:
                    'Isso é algo sério, tenha certeza antes de denunciar alguém. Caso um usuário estiver em perigo à vida ou à saúde, peça ajuda imediatamente. Não espere.',
              ),
              const SizedBox(height: UiPadding.large),
              ButtonCardWidget(
                content: _allDenounceJustify,
                callback: (value) => _selected(value),
              ),
              const SizedBox(height: UiPadding.large),
              if (_hasButton)
                Button3dWidget(
                  label: 'Denunciar',
                  style: ButtonStyleEnum.PRIMARY.value,
                  callback: (value) => _postDenounce(value),
                ),
              const SizedBox(height: UiPadding.large),
            ],
          ),
        ),
      ),
    );
  }
}