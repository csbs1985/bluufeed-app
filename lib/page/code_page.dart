import 'dart:math';
import 'package:bluuffed_app/service/interval_service.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> with TickerProviderStateMixin {
  final AuthService authService = AuthService();
  final EmailService _emailService = EmailService();
  final IntervalService intervalService = IntervalService();
  final ToastWidget toastWidget = ToastWidget();

  final TextEditingController _codeController = TextEditingController();

  DateTime _timer = DateTime.now().add(const Duration(minutes: 10));
  String _code = "0000";

  @override
  void initState() {
    super.initState();
    authService;
    _sendCode();
  }

  _sendCode() {
    _codeController.text = '';
    var _codeTemp = Random().nextInt(9999);
    if (_code != 4) _code = _codeTemp.toString().padLeft(4, '0');
    setState(() => _timer = DateTime.now().add(const Duration(minutes: 10)));
    _sendEmail();
  }

  _sendEmail() async {
    try {
      _emailService.sendEmail(
        email: currentEmail.value,
        subject: 'Código de verificação',
        name: '',
        code: _code,
        template: EmailJsEnum.CODE.value,
      );
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'código enviado para o email ${currentEmail.value}',
      );
      toastWidget.toast(context, ToastEnum.SUCCESS.value, _code);
    } catch (error) {
      debugPrint('não foi possivél enviar o código.');
    }
  }

  _endTimer() {
    toastWidget.toast(
      context,
      ToastEnum.WARNING.value,
      'tempo encerrado, vamos reiniciar o processo',
    );
    intervalService.back(context);
  }

  _validateCode() {
    if (_codeController.text == _code.toString()) {
      _code = "0000";

      if (currentForm.value == FormEnum.CREATE.value) {
        currentPasswordType.value = PasswordTypeEnum.CREATE.value;
        context.push(PageEnum.PASSWORD.value);
      }
    } else {
      _codeController.text = '';
      toastWidget.toast(
        context,
        ToastEnum.WARNING.value,
        'código informado incorreto',
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Scaffold(
          appBar: AppBarBackWidget(option: false),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Headline1(title: 'Código de verificação'),
                  const Headline2(text: 'um código pode salvar vidas...'),
                  const SizedBox(height: UiPadding.large),
                  Headline2(
                      text:
                          'Entre com o código enviado para o email ${currentEmail.value} cadastrado.'),
                  const SizedBox(height: UiPadding.large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Headline2(text: 'Válido por '),
                      TimerCountdown(
                        format: CountDownTimerFormat.minutesSeconds,
                        enableDescriptions: false,
                        timeTextStyle: Theme.of(context).textTheme.headline2,
                        colonsTextStyle: UiText.button,
                        spacerWidth: 0,
                        endTime: _timer,
                        onEnd: () => _endTimer(),
                      ),
                      const Headline2(text: ' minutos.'),
                    ],
                  ),
                  const SizedBox(height: UiPadding.large),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 56,
                      vertical: UiPadding.large,
                    ),
                    child: PinCodeTextField(
                      backgroundColor: Colors.transparent,
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: UiColor.success,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor:
                            isDark ? UiColor.backDark : UiColor.back,
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                        inactiveFillColor: Colors.transparent,
                        selectedFillColor: UiColor.primary,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      textStyle: Theme.of(context).textTheme.headline2,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onChanged: (String value) {},
                    ),
                  ),
                  Button3dWidget(
                    callback: (value) => _validateCode(),
                    label: 'validar',
                    style: ButtonStyleEnum.PRIMARY.value,
                  ),
                  const SizedBox(height: UiPadding.large),
                  ButtonHeadline2(
                    callback: (value) => _sendCode(),
                    label: 'enviar novo código',
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
