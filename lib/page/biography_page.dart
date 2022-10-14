import 'package:bluuffed_app/firestore/user_firestore.dart';
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
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BiographyPage extends StatefulWidget {
  const BiographyPage({super.key});

  @override
  State<BiographyPage> createState() => _BiographyPageState();
}

class _BiographyPageState extends State<BiographyPage> {
  final _formKey = GlobalKey<FormState>();

  final ActivityClass activityClass = ActivityClass();
  final CommentService commentService = CommentService();
  final DateService dateService = DateService();
  final HistoryService historyService = HistoryService();
  final NameService nameService = NameService();
  final TextEditingController _bioController = TextEditingController();
  final ToastWidget toastWidget = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  @override
  void initState() {
    _bioController.text = currentUser.value.first.bio;
    super.initState();
  }

  _bioChange(BuildContext context) {
    try {
      userFirestore.pathBio(_bioController.text).then((result) => {
            currentUser.value.first.bio = _bioController.text,
            toastWidget.toast(
              context,
              ToastEnum.SUCCESS.value,
              'biografia alterada',
            ),
            activityClass.save(
              type: ActivityEnum.UP_BIOGRAPHY.value,
              content: DateTime.now().toString(),
              elementId: '',
            ),
          });
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => _bioChange: $error');
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
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
                const Headline1(title: 'Biografia'),
                const Headline2(text: 'Fale um pouco sobre você.'),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  controller: _bioController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  validator: (value) => nameService.validateName(value!),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(UiPadding.large),
                    hintText: 'usuário',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _bioChange(context),
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
