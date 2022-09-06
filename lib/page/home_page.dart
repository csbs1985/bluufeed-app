import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/page/create_page.dart';
import 'package:universe_history_app/page/feed_page.dart';
import 'package:universe_history_app/page/login_page.dart';
import 'package:universe_history_app/page/notification_page.dart';
import 'package:universe_history_app/page/settings_page.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/theme/ui_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserClass _userClass = UserClass();
  final UsersFirestore _usersFirestore = UsersFirestore();

  PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    identify();
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  void identify() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        try {
          await _userClass.readUser();
          await _usersFirestore.getUserEmail(user.email).then(
                (result) => _userClass.add(
                  {
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
                ),
              );
        } on AuthException catch (error) {
          debugPrint('ERROR => getUserEmail: $error');
        }
      }
    });
  }

  void _setCurrentPage(page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _setCurrentPage,
        children: [
          const FeedPage(),
          const CreatePage(),
          const NotificationPage(),
          currentUser.value.isEmpty ? const LoginPage() : const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 0 ? UiIcon.logoActived : UiIcon.logo,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 1 ? UiIcon.createActived : UiIcon.create,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 2
                  ? UiIcon.notificationActived
                  : UiIcon.notification,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 3 ? UiIcon.moreActived : UiIcon.more,
            ),
            label: '',
          ),
        ],
        onTap: (page) => {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
        },
      ),
    );
  }
}
