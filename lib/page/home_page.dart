import 'package:bluuffed_app/page/perfil_page.dart';
import 'package:bluuffed_app/page/search_page.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/page/feed_page.dart';
import 'package:bluuffed_app/page/notification_page.dart';
import 'package:bluuffed_app/page/settings_page.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserFirestore _userFirestore = UserFirestore();
  final UserService _userService = UserService();

  PageController _pageController = PageController();

  int _currentPage = 0;

  late Map<String, dynamic> _user;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  Future<void> identify(AuthService auth) async {
    if (currentUser.value.isEmpty) {
      await _userFirestore.getUserEmail(auth.user!.email).then(
        (result) {
          _user = {
            'id': result.docs[0]['id'],
            'date': result.docs[0]['date'],
            'name': result.docs[0]['name'],
            'bio': result.docs[0]['bio'],
            'upDateName': result.docs[0]['upDateName'],
            'status': result.docs[0]['status'],
            'email': result.docs[0]['email'],
            'token': result.docs[0]['token'],
            'isNotification': result.docs[0]['isNotification'],
            'qtyBookmark': result.docs[0]['qtyBookmark'],
            'qtyComment': result.docs[0]['qtyComment'],
            'qtyDenounce': result.docs[0]['qtyDenounce'],
            'qtyHistory': result.docs[0]['qtyHistory'],
            'blocked': result.docs[0]['blocked'],
            'following': result.docs[0]['following'],
          };

          _userService.add(_user);
        },
      );
    }
  }

  void _setCurrentPage(page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    identify(authService);

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
