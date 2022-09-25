import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:bluuffed_app/widget/app_bar_widget_old.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/widget/space_x_large.widget.dart';
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
  final ToastWidget _toast = ToastWidget();

  final TextEditingController _codeController = TextEditingController();

  late int _code;

  @override
  void initState() {
    super.initState();
    authService;
    _sendCode();
  }

  _sendCode() {
    _code = Random().nextInt(999) + 1000;
    _sendEmail();
  }

  _sendEmail() async {
    try {
      _emailService.sendEmail(
        email: currentEmail.value,
        subject: 'Código de verificação',
        name: '',
        code: _code.toString(),
        template: EmailJsEnum.CODE.value,
      );
      _toast.toast(
        context,
        ToastEnum.SUCCESS.value,
        'código enviado para o email ${currentEmail.value}',
      );
    } catch (error) {
      debugPrint('não foi possivél enviar o código.');
    }
  }

  _endTimer() {
    _toast.toast(
      context,
      ToastEnum.WARNING.value,
      'tempo encerrado, vamos reiniciar o processo',
    );
    Navigator.pop(context);
  }

  _validateCode() {
    if (_codeController.text == _code.toString()) {
      _code = 0;

      if (currentForm.value == FormEnum.LOGIN.value)
        Navigator.pushNamed(context, PageEnum.PASSWORD.value);
      else
        Navigator.pushNamed(context, PageEnum.PASSWORD_CREATE.value);
    } else {
      _codeController.text = '';
      _toast.toast(
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
      appBar: const AppBarWidgetOld(title: 'Código de verificação'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(UiPadding.xLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(UiIcon.identity),
              const SpaceXLargeWidget(),
              TextWidget(
                text:
                    'Enviamos um código de verificação com quatro digitos numéricos para o email ${currentEmail.value} cadastrado. '
                    'Caso não confirme abaixo com o código em até 10 (cinco) minutos a operação é cancelada e você deverá reinicar o precesso. '
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
                    width: 291,
                    child: TextWidget(
                      text:
                          'Por favor, insira o código de validação recebido em ',
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
                        minutes: 10,
                        seconds: 0,
                      ),
                    ),
                    onEnd: () => _endTimer(),
                  ),
                  const SizedBox(
                    width: 1,
                    child: TextWidget(
                      text: '.',
                    ),
                  ),
                ],
              ),
              const SpaceXLargeWidget(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 56),
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
              const SpaceXLargeWidget(),
              Button3dWidget(
                callback: (value) => _validateCode(),
                label: 'validar',
                style: ButtonStyleEnum.PRIMARY.value,
                size: ButtonSizeEnum.LARGE.value,
                padding: UiSize.paddingPageSmall,
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
