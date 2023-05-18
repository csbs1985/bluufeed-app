import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/button/menu_button.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/modal/sair_modal.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<MenuPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<MenuPage> {
  void _abrirModalSair(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const SairModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TituloText(titulo: MENU),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
                child: TextoText(texto: CONTA),
              ),
              MenuButton(
                callback: () => context.pushNamed(RouteEnum.PERFIL.value,
                    params: {'idUsuario': widget._idUsuario}),
                subtitulo: PERFIL,
                resumo: PERFIL_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.pushNamed(RouteEnum.EDITAR_PERFIL.value,
                    params: {'idUsuario': widget._idUsuario}),
                subtitulo: USUARIO_EDITAR,
                resumo: EDITAR_PERFIL_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.pushNamed(RouteEnum.NOTIFICACAO.value,
                    params: {'idUsuario': widget._idUsuario}),
                subtitulo: NOTIFICACAO,
                resumo: NOTIFICACAO_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.pushNamed(RouteEnum.ATIVIDADE.value,
                    params: {'idUsuario': widget._idUsuario}),
                subtitulo: ATIVIDADE,
                resumo: ATIVIDADE_DESCICAO,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
                child: TextoText(texto: INFORMACOES),
              ),
              MenuButton(
                callback: () => context.push(RouteEnum.PERGUNTAS.value),
                subtitulo: PERGUNTAS,
                resumo: PERGUNTAS_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.push(RouteEnum.TERMO.value),
                subtitulo: TERMO,
                resumo: TERMO_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.push(RouteEnum.POLITICA.value),
                subtitulo: POLITICA,
                resumo: POLITICA_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.push(RouteEnum.SOBRE.value),
                subtitulo: SOBRE,
                resumo: SOBRE_DESCRICAO,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 16),
                child: TextoText(texto: FINALIZAR),
              ),
              MenuButton(
                callback: () => _abrirModalSair(context),
                subtitulo: SAIR,
                resumo: SAIR_DESCRICAO,
              ),
              const SizedBox(height: 8),
              MenuButton(
                callback: () => context.push(RouteEnum.DELETAR_CONTA.value),
                subtitulo: DELETAR,
                resumo: DELETAR_DESCRICAO,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
