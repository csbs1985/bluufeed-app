import 'package:bluuffed_app/page/feed_page.dart';
import 'package:bluuffed_app/page/notification_page.dart';
import 'package:bluuffed_app/page/perfil_page.dart';
import 'package:bluuffed_app/page/search_page.dart';
import 'package:bluuffed_app/page/settings_page.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
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
