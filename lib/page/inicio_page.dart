import 'package:bluufeed_app/page/busca_page.dart';
import 'package:bluufeed_app/page/configuracao_page.dart';
import 'package:bluufeed_app/page/notificacao_page.dart';
import 'package:bluufeed_app/page/perfil_part.dart';
import 'package:bluufeed_app/page/principal_page.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
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
          PrincipalPage(),
          BuscaPage(),
          NotificacaoPage(),
          PerfilPage(),
          ConfiguracaoPage(),
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
              _currentPage == 0 ? UiSvg.principalAtivo : UiSvg.principal,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 1 ? UiSvg.buscarAtivo : UiSvg.buscar,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 2 ? UiSvg.notificacaoAtivo : UiSvg.notificacao,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 3 ? UiSvg.perfilAtivo : UiSvg.perfil,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentPage == 4 ? UiSvg.maisAtivo : UiSvg.mais,
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
