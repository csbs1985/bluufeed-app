import 'dart:math';
import 'package:bluuffed_app/service/interval_service.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

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

  String _code = "0000";

  @override
  void initState() {
    super.initState();
    authService;
    _sendCode();
  }

  _sendCode() {
    var _codeTemp = Random().nextInt(9999);
    if (_code != 4) {
      _code = _codeTemp.toString().padLeft(4, '0');
    }
    _sendEmail();
  }

  _sendEmail() async {
    try {
      // _emailService.sendEmail(
      //   email: currentEmail.value,
      //   subject: 'Código de verificação',
      //   name: '',
      //   code: _code,
      //   template: EmailJsEnum.CODE.value,
      // );
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        _code,
        // 'código enviado para o email ${currentEmail.value}',
      );
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

      if (currentForm.value == FormEnum.LOGIN.value) {
        currentPasswordType.value = PasswordTypeEnum.LOGIN.value;
        Navigator.pushNamed(context, PageEnum.PASSWORD.value);
      } else {
        currentPasswordType.value = PasswordTypeEnum.CREATE.value;
        Navigator.pushNamed(context, PageEnum.PASSWORD.value);
      }
    } else {
      _codeController.text = '';
      toastWidget.toast(
          context, ToastEnum.WARNING.value, 'código informado incorreto');
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headline1(title: 'Código de verificação'),
              const TextAnimationWidget(text: 'um código pode salvar vidas...'),
              const SizedBox(height: UiPadding.large),
              Headline2(
                text:
                    'Enviamos um código de verificação com quatro digitos numéricos para o email ${currentEmail.value} cadastrado. '
                    'Caso não confirme abaixo com o código em até 10 (cinco) minutos a operação é cancelada e você deverá reinicar o precesso. '
                    '\n'
                    'Se precisar bastar solicitar um novo código de verificação. ',
              ),
              const SizedBox(height: UiPadding.large),
              const Headline2(
                text:
                    'Caso não consigo visualizar o email, confira sua caixa de span.',
              ),
              const SizedBox(height: UiPadding.large),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 291,
                    child: Headline2(
                        text:
                            'Por favor, insira o código de validação recebido em '),
                  ),
                  TimerCountdown(
                    format: CountDownTimerFormat.minutesSeconds,
                    enableDescriptions: false,
                    timeTextStyle: UiText.button,
                    colonsTextStyle: UiText.button,
                    spacerWidth: 1,
                    endTime: DateTime.now().add(const Duration(minutes: 10)),
                    onEnd: () => _endTimer(),
                  ),
                  const SizedBox(
                    width: 1,
                    child: Headline2(text: '.'),
                  ),
                ],
              ),
              const SizedBox(height: UiPadding.large),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 56,
                  vertical: UiPadding.large,
                ),
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
  }
}
