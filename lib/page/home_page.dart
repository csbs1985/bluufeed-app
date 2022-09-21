import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/page/feed_page.dart';
import 'package:bluuffed_app/page/notification_page.dart';
import 'package:bluuffed_app/page/settings_page.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final UserClass _userClass = UserClass();
  final UserFirestore _userFirestore = UserFirestore();

  PageController _pageController = PageController();

  int _currentPage = 0;

  late Map<String, dynamic> _user;

  @override
  void initState() {
    identify();
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  Future<void> identify() async {
    if (currentUser.value.isEmpty) {
      await _userFirestore
          .getUserEmail(_authService.auth.currentUser!.email)
          .then(
        (result) {
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
          };

          _userClass.add(_user);
        },
      );
    }
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
        children: const [
          FeedPage(),
          NotificationPage(),
          SettingsPage(),
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
              _currentPage == 1
                  ? UiIcon.notificationActived
                  : UiIcon.notification,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 2 ? UiIcon.moreActived : UiIcon.more,
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
