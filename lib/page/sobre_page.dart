import 'package:eight_app/appbar/voltar_appbar.dart';
import 'package:eight_app/text/texto_text.dart';
import 'package:eight_app/text/titulo_text.dart';
import 'package:eight_app/theme/ui_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  _SobrePage createState() => _SobrePage();
}

class _SobrePage extends State<SobrePage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TituloText(titulo: 'Sobre'),
              const SizedBox(height: 24),
              SvgPicture.asset(UiSvg.identidade),
              const SizedBox(height: 24),
              TextoText(
                texto: 'Versão'
                    '\n'
                    'v${_packageInfo.version}'
                    '\n\n'
                    'Número do build'
                    '\n'
                    '${_packageInfo.buildNumber}'
                    '\n\n'
                    'Bluufeed e os logotipos e logomarcas do Bluufeed são marcas registradas.'
                    '\n\n'
                    'Todos os direitos registrados.'
                    '\n\n'
                    'Bluufeed foi construído usando software de código aberto e licenciado.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
