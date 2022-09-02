import 'package:flutter/material.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/widget/app_bar_widget.dart';
import 'package:universe_history_app/widget/select_category_widget.dart';

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
  List<CategoryModel> allCategories = CategoryModel.allCategories;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectCategoriesWidget(
              title: 'Assunto',
              resume: 'Selecione ao menos uma categoria/tema.',
              content: allCategories,
              selected: currentHistory.value.isNotEmpty
                  ? currentHistory.value.first.categories
                  : [],
              callback: (value) => _setCategories(value),
            )
          ],
        ),
      ),
    );
  }
}
