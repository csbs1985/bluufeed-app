import 'package:bluuffed_app/button/button_follow_widget.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/modal/opiton_modal.dart';
import 'package:bluuffed_app/model/modal_model.dart';
import 'package:bluuffed_app/model/perfil_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/skeleton/history_item_skeleton.dart';
import 'package:bluuffed_app/skeleton/perfil_skeleton.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/history_item_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';
import 'package:bluuffed_app/widget/perfil_Item_widget.dart';
import 'package:bluuffed_app/widget/since_widget.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:bluuffed_app/widget/subtitle_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final PerfilClass perfilClass = PerfilClass();
  final UserFirestore userFirestore = UserFirestore();

  late Map<String, dynamic> _perfil;
  late String _user;

  bool _isAnotherUser = false;

  String _tab = PerfilTabEnum.HISTORY.value;

  isAuthor() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _user = ModalRoute.of(context)!.settings.arguments.toString();
      _isAnotherUser = true;
    } else {
      _user = currentUser.value.first.id;
      _isAnotherUser = false;
    }
  }

  isCurrentUser() {
    return _user == currentUser.value.first.id ? true : false;
  }

  void _openModal(BuildContext context, Map<String, dynamic> _content) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return OptionModal(
          content: _content,
          type: ModalEnum.OPTION_PERFIL.value,
        );
      },
    );
  }

  _setTab(String tab) {
    setState(() {
      _tab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    isAuthor();

    return Scaffold(
      appBar: !_isAnotherUser
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(),
            )
          : AppBarBackWidget(
              option: true,
              callback: (value) => _openModal(context, _perfil),
            ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: userFirestore.getUserIdSnapshots(_user),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _noResults();

              case ConnectionState.waiting:
                return const PerfilSkeleton();

              case ConnectionState.done:
              default:
                try {
                  _perfil = {
                    'id': snapshot.data!.docs[0]['id'],
                    'date': snapshot.data!.docs[0]['date'],
                    'name': snapshot.data!.docs[0]['name'],
                    'bio': snapshot.data!.docs[0]['bio'],
                    'upDateName': snapshot.data!.docs[0]['upDateName'],
                    'status': snapshot.data!.docs[0]['status'],
                    'email': snapshot.data!.docs[0]['email'],
                    'token': snapshot.data!.docs[0]['token'],
                    'isNotification': snapshot.data!.docs[0]['isNotification'],
                    'qtyComment': snapshot.data!.docs[0]['qtyComment'],
                    'qtyDenounce': snapshot.data!.docs[0]['qtyDenounce'],
                    'qtyHistory': snapshot.data!.docs[0]['qtyHistory'],
                    'following': snapshot.data!.docs[0]['following'],
                  };

                  return _perfilItem(_perfil);
                } catch (error) {
                  return _noResults();
                }
            }
          },
        ),
      ),
    );
  }

  Widget _perfilItem(Map<String, dynamic> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Headline1(title: 'Perfil'),
                Headline1(title: snapshot['name']),
                if (isCurrentUser())
                  SubtitleResumeWidget(
                    title: 'email',
                    resume: snapshot['email'],
                  ),
                if (isCurrentUser()) const SizedBox(height: UiPadding.large),
                SinceWidget(date: snapshot['date']),
                const SizedBox(height: UiPadding.large),
                SubtitleResumeWidget(
                  title: 'biografia',
                  resume: snapshot['bio'],
                ),
                const SizedBox(height: UiPadding.large),
                SubtitleResumeWidget(
                  title: 'interações',
                  resume: '${snapshot['qtyComment'].toString()} comentários',
                ),
                if (!isCurrentUser()) const SizedBox(height: UiPadding.large),
                if (!isCurrentUser()) ButtonFollowWidget(perfil: _perfil),
                const SizedBox(height: UiPadding.large),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PerfilItemWidget(
                      title: 'histórias',
                      resume: snapshot['qtyHistory'].toString(),
                      callback: (value) => _setTab(PerfilTabEnum.HISTORY.value),
                    ),
                    const SizedBox(width: UiPadding.large),
                    PerfilItemWidget(
                      title: 'ler depois',
                      resume: snapshot['qtyComment'].toString(),
                      callback: (value) => _setTab(
                        PerfilTabEnum.BOOKMARK.value,
                      ),
                    ),
                    const SizedBox(width: UiPadding.large),
                    PerfilItemWidget(
                      title: 'seguindo',
                      resume: snapshot['following'].length.toString(),
                      callback: (value) => _setTab(PerfilTabEnum.USER.value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_tab == PerfilTabEnum.HISTORY.value) _listHistory(),
          if (_tab == PerfilTabEnum.USER.value) _listUsers(),
          if (_tab == PerfilTabEnum.BOOKMARK.value) _listBookmarks(),
        ],
      ),
    );
  }

  Widget _listHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(UiPadding.large),
          child: SubtitleWidget(resume: 'histórias'),
        ),
        FirestoreListView(
          query: historyFirestore.stories
              .orderBy('date')
              .where('userId', isEqualTo: _user),
          pageSize: 10,
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          loadingBuilder: (context) => const HistoryItemSkeleton(),
          errorBuilder: (context, error, _) => const HistoryItemSkeleton(),
          itemBuilder:
              (BuildContext context, QueryDocumentSnapshot<dynamic> snapshot) {
            return HistoryItemWidget(snapshot: snapshot.data());
          },
        ),
      ],
    );
  }

  Widget _listBookmarks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(UiPadding.large),
          child: SubtitleWidget(resume: 'ler depois'),
        ),
        FirestoreListView(
          query: historyFirestore.stories.orderBy('date').where('bookmarks',
              arrayContainsAny: [currentUser.value.first.id]),
          pageSize: 10,
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          loadingBuilder: (context) => const HistoryItemSkeleton(),
          errorBuilder: (context, error, _) => const HistoryItemSkeleton(),
          itemBuilder:
              (BuildContext context, QueryDocumentSnapshot<dynamic> snapshot) {
            return HistoryItemWidget(snapshot: snapshot.data());
          },
        ),
      ],
    );
  }

  Widget _listUsers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(UiPadding.large),
          child: SubtitleWidget(resume: 'seguindo'),
        ),
        FirestoreListView(
          query: historyFirestore.stories
              .orderBy('date')
              .where('userId', isEqualTo: _user),
          pageSize: 10,
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          loadingBuilder: (context) => const HistoryItemSkeleton(),
          errorBuilder: (context, error, _) => const HistoryItemSkeleton(),
          itemBuilder:
              (BuildContext context, QueryDocumentSnapshot<dynamic> snapshot) {
            return HistoryItemWidget(snapshot: snapshot.data());
          },
        ),
      ],
    );
  }

  Widget _noResults() {
    return Column(
      children: [
        if (_isAnotherUser) const SizedBox(height: UiSize.appBar),
        const NoResultWidget(text: 'Não foi possível encontrar usuário'),
      ],
    );
  }
}
