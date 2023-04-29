import 'package:bluufeed_app/button/publicar_button.dart';
import 'package:bluufeed_app/class/atividade_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/firestore/historia_firebase.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/selecionar_categoria_widget.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:bluufeed_app/widget/toggle_selecionar_widget.dart';
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
  final AtividadeClass _atividadeClass = AtividadeClass();
  final HistoriaClass _historiaClass = HistoriaClass();
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();
  final ToastWidget _toastWidget = ToastWidget();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();
  final Uuid uuid = const Uuid();

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _categorias = [];

  bool _isEdito = false;
  bool _isAssinado = true;
  bool _isComentario = true;
  bool _isAutorizado = false;
  bool _btnPublicar = false;

  late Map<String, dynamic> _history;
  late Map<String, dynamic> activity;

  @override
  void initState() {
    if (currentHistoria.value != "") {
      _isEdito = true;
      _btnPublicar = true;
      titleController.text = currentHistoria.value.titulo;
      textController.text = currentHistoria.value.texto;
      _isAssinado = currentHistoria.value.isAnonimo;
      _isComentario = currentHistoria.value.isComentario;
      _isAutorizado = currentHistoria.value.isAutorizado;
      _categorias = currentHistoria.value.categorias.cast<String>();
    }

    super.initState();
  }

  void _setPrivacy() {
    setState(() {
      _isAssinado = !_isAssinado;
      _canPublish();
    });
  }

  void _setContent() {
    setState(() {
      _isComentario = !_isComentario;
      _canPublish();
    });
  }

  void _setAuthorized() {
    setState(() {
      _isAutorizado = !_isAutorizado;
      _canPublish();
    });
  }

  void _setCategory(List<String> value) {
    setState(() {
      _categorias = value;
      _canPublish();
    });
  }

  void _canPublish() {
    setState(() {
      _btnPublicar = (titleController.text != "" &&
              textController.text != "" &&
              _categorias != "")
          ? true
          : false;
    });
  }

  Future<void> _postHistory(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      if (currentHistoria.value != "") {
        _history = {
          'idHistoria': currentHistoria.value.idHistoria,
          'titulo': titleController.text.trim(),
          'texto': textController.text.trim(),
          'dataCriacao': currentHistoria.value.dataCriacao,
          'isComentario': _isComentario,
          'isAnonimo': _isAssinado,
          'isEdito': true,
          'isAutorizado': _isAutorizado,
          'qtdComentario': currentHistoria.value.qtdComentario,
          'categorias': _categorias,
          'idUsuario': currentUsuario.value.idUsuario,
          'nomeUsuario': currentUsuario.value.nomeUsuario,
          'avatarUsuario': '',
          'favoritos': currentHistoria.value.favoritos,
        };
      } else {
        _history = {
          'idHistoria': uuid.v4(),
          'titulo': titleController.text.trim(),
          'texto': textController.text.trim(),
          'date': DateTime.now().toString(),
          'isComentario': _isComentario,
          'isAnonimo': _isAssinado,
          'isEdito': false,
          'isAutorizado': _isAutorizado,
          'qtdComentario': 0,
          'categorias': _categorias,
          'idUsuario': currentUsuario.value.idUsuario,
          'nomeUsuario': currentUsuario.value.nomeUsuario,
          'avatarUsuario': "",
          'favoritos': [],
        };
      }

      _historiaClass.adicionar(_history);
    });

    try {
      await _historiaFirestore.postHistory(_history);
      _pathQtyHistoryUser();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewHistory: $error');
      _toastWidget.toast(context, ToastEnum.ERRO, HISTORIA_ERRO_PUBLICAR);
    }
  }

  Future<void> _pathQtyHistoryUser() async {
    if (!_isEdito) currentUsuario.value.qtdHistorias++;

    try {
      await _usuarioFirestore.pathQtdHistorias(currentUsuario.value);
      _atividadeClass.post(
        type: _isEdito
            ? AtividadeEnum.NEW_HISTORY.value
            : AtividadeEnum.UP_HISTORY.value,
        content: titleController.text,
        elementId: _history['id'],
      );
      if (currentHistoria.value != "") Navigator.of(context).pop();

      _toastWidget.toast(
        context,
        ToastEnum.SUCESSO,
        _isEdito ? HISTORIA_ALTERADA : HISTORIA_PUBLICADA,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => pathQtyHistoryUser: $error');
    }
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
            backgroundColor: isDark ? UiCor.mainEscuro : UiCor.main,
            elevation: 0,
            titleSpacing: 0,
            leading: IconButton(
              icon: SvgPicture.asset(UiSvg.fechar),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              if (_btnPublicar)
                Padding(
                  padding: const EdgeInsets.only(right: UiEspaco.large),
                  child: PublicarButton(
                    callback: (value) => _postHistory(context),
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                UiEspaco.large,
                0,
                UiEspaco.large,
                UiEspaco.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 60,
                    style: Theme.of(context).textTheme.displayMedium,
                    onChanged: (value) => _canPublish(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      counterText: "",
                      fillColor: isDark ? UiCor.mainEscuro : UiCor.main,
                      hintText: HISTORIA_TITULO,
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: UiEspaco.large),
                  TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    style: Theme.of(context).textTheme.displayMedium,
                    onChanged: (value) => _canPublish(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: isDark ? UiCor.mainEscuro : UiCor.main,
                      hintText: HISTORIA_TEXTO,
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: UiEspaco.large),
                  SelecionatCategoriaWidget(
                    selecionado: currentHistoria.value != ""
                        ? currentHistoria.value.categorias
                        : [],
                    callback: (value) => _setCategory(value),
                  ),
                  const SizedBox(height: UiEspaco.large),
                  ToggleSelecionarWidget(
                    titulo: ASSINATURA,
                    resumo:
                        '$ASSINATURA_HABILITAR_1 ${currentUsuario.value.nomeUsuario} $ASSINATURA_HABILITAR_2',
                    value: _isAssinado,
                    callback: (value) => _setPrivacy(),
                  ),
                  const SizedBox(height: UiEspaco.large),
                  ToggleSelecionarWidget(
                    titulo: COMENTARIOS,
                    resumo: COMENTARIOS_HABILITAR,
                    value: _isComentario,
                    callback: (value) => _setContent(),
                  ),
                  const SizedBox(height: UiEspaco.large),
                  ToggleSelecionarWidget(
                    titulo: AUTORIZADO,
                    resumo: AUTORIZADO_HABILITAR,
                    value: _isAutorizado,
                    callback: (value) => _setAuthorized(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
