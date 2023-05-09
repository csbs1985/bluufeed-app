import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:bluufeed_app/widget/usuario_item.dart';
import 'package:flutter/material.dart';

class UsuarioListaWidget extends StatefulWidget {
  const UsuarioListaWidget({
    super.key,
    required List<Map<String, dynamic>> usuario,
  }) : _usuario = usuario;

  final List<Map<String, dynamic>> _usuario;

  @override
  State<UsuarioListaWidget> createState() => _UsuarioListaWidgetState();
}

class _UsuarioListaWidgetState extends State<UsuarioListaWidget> {
  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return widget._usuario.isEmpty
        ? SemResultadoWidget(altura: _altura)
        : Column(
            children: [
              const SizedBox(height: 16),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: widget._usuario.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  return UsuarioItemWidget(usuario: widget._usuario[index]);
                },
              ),
            ],
          );
  }
}
