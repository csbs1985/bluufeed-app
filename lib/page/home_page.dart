import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/page/feed_page.dart';
import 'package:bluuffed_app/page/notification_page.dart';
import 'package:bluuffed_app/page/perfil_page.dart';
import 'package:bluuffed_app/page/search_page.dart';
import 'package:bluuffed_app/page/settings_page.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/user_service.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final UserFirestore _userFirestore = UserFirestore();
  final UserService _userService = UserService();

  PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  Future<void> identify(AuthService _authService) async {
    try {
      await _userFirestore
          .getUserId(_authService.user!.uid)
          .then((result) async {
        // if (currentUser.value.first.email.isEmpty)
        await _authService.setCurrentUser(
            context, ActivityEnum.NEW_ACCOUNT.name);
        // _userService.setModelUser(result);
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => identify: ' + error.toString());
    }
  }

  void _setCurrentPage(page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);

    identify(_authService);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _setCurrentPage,
        children: const [
          FeedPage(),
          SearchPage(),
          NotificationPage(),
          PerfilPage(),
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
              _currentPage == 0 ? UiIcon.homeActived : UiIcon.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 1 ? UiIcon.searcActived : UiIcon.search,
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
              _currentPage == 3 ? UiIcon.perfilActived : UiIcon.perfil,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 4 ? UiIcon.moreActived : UiIcon.more,
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
