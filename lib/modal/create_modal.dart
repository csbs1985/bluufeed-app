import 'package:flutter/material.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/app_bar_widget.dart';
import 'package:universe_history_app/widget/select_category_widget.dart';
import 'package:universe_history_app/widget/select_toggle_widget.dart';

class CreateModal extends StatefulWidget {
  const CreateModal({Key? key}) : super(key: key);

  @override
  State<CreateModal> createState() => _CreateModalState();
}

class _CreateModalState extends State<CreateModal> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _categories = [];

  bool isEdit = false;
  bool _isSigned = true;
  bool _isComment = true;
  bool _btnPublish = false;
  bool _isAuthorized = false;

  @override
  void initState() {
    if (currentHistory.value.isNotEmpty) {
      isEdit = true;
      _btnPublish = true;
      titleController.text = currentHistory.value.first.title;
      textController.text = currentHistory.value.first.text;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppbarWidget(
        btnBack: true,
        btnPublish: _btnPublish,
        // callback: (value) => _postHistory(context),
        callback: (value) => {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            UiPadding.medium,
            UiPadding.large,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectToggleWidget(
                title: 'Autorizado',
                resume:
                    'Ligado para marcar história como de terceiro com autorização para publicar. ',
                value: _isAuthorized,
                callback: (value) => _setAuthorized(),
              ),
              const SizedBox(height: UiPadding.xLarge),
              SelectCategoriesWidget(
                selected: currentHistory.value.isNotEmpty
                    ? currentHistory.value.first.categories
                    : [],
                callback: (value) => _setCategories(value),
              )
            ],
          ),
        ),
      ),
    );
  }
}
