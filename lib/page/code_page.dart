import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/service/email_service.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text.dart';
import 'package:universe_history_app/widget/app_bar_widget%20.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> with TickerProviderStateMixin {
  final AuthService authService = AuthService();
  final EmailService _emailService = EmailService();
  final ToastWidget _toast = ToastWidget();

  final TextEditingController _codeController = TextEditingController();

  final _user = 'csbs.conta@outlook.com';

  late int _code;

  @override
  void initState() {
    authService;

    _sendCode();
    super.initState();
  }

  _sendCode() {
    _random();
  }

  _random() {
    var rng = Random();
    _code = rng.nextInt(9999) + 1000;

    _sendEmail();
  }

  _sendEmail() async {
    try {
      _emailService.sendEmail(
        name: 'charles.sbs1',
        email: _user,
        subject: 'subject',
        message: 'message',
        code: _code.toString(),
      );
      print('código enviado para sua caixa de entrada');
    } catch (e) {
      print('não foi possivél enviar o código.');
    }
  }

  _endTimer() {
    _toast.toast(context, ToastEnum.WARNING.value,
        'tempo encerrado, reinicie o processo');
  }

  _validateCode() {
    if (_codeController.text == _code.toString()) {
      _toast.toast(context, ToastEnum.SUCCESS.value, 'certo, seja bem vindo!');
    } else {
      _toast.toast(
          context, ToastEnum.WARNING.value, 'código informado incorreto');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(isBack: true, title: 'Código de verificação'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Column(
            children: [
              TextWidget(
                text:
                    'Enviamos um código de verificação com quatro digitos numéricos para o email $_user cadastrado. '
                    'Caso não confirme abaixo com o código em até 5 (cinco) minutos a operação é cancelada e deve ser reiniciada. '
                    'Se precisar bastar solicitar um novo código de verificação. ',
              ),
              const SizedBox(height: UiPadding.large),
              const TextWidget(
                text:
                    'Caso não consigo visualizar o email, confira sua caixa de span.',
              ),
              const SizedBox(height: UiPadding.large),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 94,
                    child: TextWidget(
                      text: 'Tempo restante ',
                    ),
                  ),
                  TimerCountdown(
                    format: CountDownTimerFormat.minutesSeconds,
                    enableDescriptions: false,
                    timeTextStyle: UiText.button,
                    colonsTextStyle: UiText.button,
                    spacerWidth: 1,
                    endTime: DateTime.now().add(
                      const Duration(
                        minutes: 5,
                        seconds: 0,
                      ),
                    ),
                    onEnd: () => _endTimer(),
                  ),
                ],
              ),
              const SizedBox(height: UiPadding.xLarge),
              SizedBox(
                width: 260,
                child: PinCodeTextField(
                  controller: _codeController,
                  length: 4,
                  appContext: context,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.number,
                  textStyle: Theme.of(context).textTheme.headline2,
                  backgroundColor: Colors.transparent,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                    fieldHeight: UiSize.input,
                    activeFillColor: UiColor.primary,
                    inactiveFillColor: Colors.transparent,
                    selectedFillColor: UiColor.primary,
                  ),
                ),
              ),
              const SizedBox(height: UiPadding.xLarge),
              Button3dWidget(
                callback: (value) => _validateCode(),
                label: 'validar',
                style: ButtonStyleEnum.PRIMARY.value,
                size: ButtonSizeEnum.LARGE.value,
                padding: UiPadding.large * 2,
              ),
              const SizedBox(height: UiPadding.large),
              ButtonTextWidget(
                callback: (value) => _sendCode(),
                label: 'enviar novo código',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
