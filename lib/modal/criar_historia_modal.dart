import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/historia_firestore.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/selecionar_categoria_widget.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:bluufeed_app/button/toggle_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

class CriarHistoriaModal extends StatefulWidget {
  const CriarHistoriaModal({Key? key}) : super(key: key);

  @override
  State<CriarHistoriaModal> createState() => _CreatePageState();
}

class _CreatePageState extends State<CriarHistoriaModal> {
  final HistoriaClass _historiaClass = HistoriaClass();
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();
  final ToastWidget _toastWidget = ToastWidget();
  final UsuarioClass _usuarioClass = UsuarioClass();
  final Uuid uuid = const Uuid();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _categorias = [];

  bool _isEditado = false;
  bool _isAssinado = true;
  bool _isComentario = true;
  bool _isAutorizado = false;
  bool _btnPublicar = false;

  late Map<String, dynamic> _historia;

  @override
  void initState() {
    if (currentHistoria.value.idHistoria != "") {
      _isEditado = true;
      _btnPublicar = true;
      _tituloController.text = currentHistoria.value.titulo;
      _textoController.text = currentHistoria.value.texto;
      _isAssinado = currentHistoria.value.isAnonimo;
      _isComentario = currentHistoria.value.isComentario;
      _isAutorizado = currentHistoria.value.isAutorizado;
      _categorias = currentHistoria.value.categorias.cast<String>();
    }

    super.initState();
  }

  void _definirAssinado() {
    setState(() => _isAssinado = !_isAssinado);
  }

  void _definirComentario() {
    setState(() => _isComentario = !_isComentario);
  }

  void _definirAutorizado() {
    setState(() => _isAutorizado = !_isAutorizado);
  }

  void _definirCategoria(List<String> value) {
    setState(() {
      _categorias = value;
      _isFloatingActionButton();
    });
  }

  void _isFloatingActionButton() {
    setState(() {
      _btnPublicar = _tituloController.text.isEmpty ||
              _textoController.text.isEmpty ||
              _categorias.isEmpty
          ? false
          : true;
    });
  }

  Future<void> _postHistoria(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      if (currentHistoria.value.idHistoria != "") {
        _historia = {
          'idHistoria': currentHistoria.value.idHistoria,
          'titulo': _tituloController.text.trim(),
          'texto': _textoController.text.trim(),
          'dataRegistro': currentHistoria.value.dataRegistro,
          'isComentario': _isComentario,
          'isAnonimo': _isAssinado,
          'isEditado': true,
          'isAutorizado': _isAutorizado,
          'qtdComentario': currentHistoria.value.qtdComentario,
          'categorias': _categorias,
          'idUsuario': currentUsuario.value.idUsuario,
          'nomeUsuario': currentUsuario.value.nomeUsuario,
          'avatarUsuario': currentUsuario.value.avatarUsuario,
        };
      } else {
        _historia = {
          'idHistoria': uuid.v4(),
          'titulo': _tituloController.text.trim(),
          'texto': _textoController.text.trim(),
          'dataRegistro': DateTime.now().toString(),
          'isComentario': _isComentario,
          'isAnonimo': _isAssinado,
          'isEditado': false,
          'isAutorizado': _isAutorizado,
          'qtdComentario': 0,
          'categorias': _categorias,
          'idUsuario': currentUsuario.value.idUsuario,
          'nomeUsuario': currentUsuario.value.nomeUsuario,
          'avatarUsuario': currentUsuario.value.avatarUsuario,
        };
      }

      _historiaClass.adicionar(_historia);
    });

    try {
      await _historiaFirestore.postHistoria(_historia);
      _pathQtdHistoriasUsuario();
    } on FirebaseAuthException {
      _toastWidget.toast(context, ToastEnum.ERRO, ERRO_PUBLICAR_HISTORIA);
    }
  }

  Future<void> _pathQtdHistoriasUsuario() async {
    if (!_isEditado) currentUsuario.value.qtdHistorias++;

    _usuarioClass.pathQtdHistoriasUsuario(
      context,
      _isEditado,
      _tituloController.text,
      _historia['id'],
    );

    if (currentHistoria.value.idHistoria != "") Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TextoText(
              texto: currentHistoria.value.idHistoria == ''
                  ? HISTORIA_CRIAR
                  : HISTORIA_EDITAR,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    controller: _tituloController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 60,
                    style: Theme.of(context).textTheme.displayMedium,
                    onChanged: (value) => _isFloatingActionButton(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      counterText: "",
                      fillColor: isDark ? UiCor.mainEscuro : UiCor.main,
                      hintText: HISTORIA_TITULO,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    controller: _textoController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    style: Theme.of(context).textTheme.displayMedium,
                    onChanged: (value) => _isFloatingActionButton(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: isDark ? UiCor.mainEscuro : UiCor.main,
                      hintText: HISTORIA,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(height: UiEspaco.large),
                SelecionatCategoriaWidget(
                  selecionado: currentHistoria.value != ""
                      ? currentHistoria.value.categorias
                      : [],
                  callback: (value) => _definirCategoria(value),
                ),
                const SizedBox(height: UiEspaco.small),
                ToggleButton(
                  subtitulo: ASSINATURA,
                  resumo:
                      '$ASSINATURA_HABILITAR_1 ${currentUsuario.value.nomeUsuario} $ASSINATURA_HABILITAR_2',
                  value: _isAssinado,
                  callback: (value) => _definirAssinado(),
                ),
                ToggleButton(
                  subtitulo: COMENTARIOS,
                  resumo: COMENTARIOS_HABILITAR,
                  value: _isComentario,
                  callback: (value) => _definirComentario(),
                ),
                ToggleButton(
                  subtitulo: AUTORIZADO,
                  resumo: AUTORIZADO_HABILITAR,
                  value: _isAutorizado,
                  callback: (value) => _definirAutorizado(),
                ),
                const SizedBox(height: 96),
              ],
            ),
          ),
          floatingActionButton: _btnPublicar
              ? FloatingActionButton(
                  backgroundColor: UiCor.botao,
                  elevation: 0,
                  onPressed: () => _postHistoria(context),
                  child: SvgPicture.asset(UiSvg.confirmar, color: UiCor.icone),
                )
              : null,
        );
      },
    );
  }
}
