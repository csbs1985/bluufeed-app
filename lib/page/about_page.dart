import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            0,
            UiPadding.large,
            UiPadding.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headline1(title: 'Sobre'),
              const SizedBox(height: UiPadding.xLarge),
              SvgPicture.asset(UiIcon.identity),
              const SizedBox(height: UiPadding.xLarge),
              TextWidget(
                text: 'Versão'
                    '\n'
                    'v${_packageInfo.version}'
                    '\n\n'
                    'Número do build'
                    '\n'
                    '${_packageInfo.buildNumber}'
                    '\n\n'
                    'bluufeed e os logotipos e logomarcas do bluufeed são marcas registradas de Universe Inc.'
                    '\n\n'
                    'Todos os direitos registrados.'
                    '\n\n'
                    'bluufeed foi construído usando software de código aberto e licenciado.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
