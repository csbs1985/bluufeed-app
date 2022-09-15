import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/app_bar_widget.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/text_animation_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  _setName() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Nome de usuário'),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextAnimationWidget(text: 'agora vem a senha...'),
                const SizedBox(height: UiPadding.large),
                const TextWidget(
                  text: 'Crie uma senha seguindo o padrão abaixo e a confirme.'
                      '\n\n'
                      '- deves ter somente letras, números e caracteres especiais'
                      '\n'
                      '- deve ter no mínimo uma letra maiúscula e minúscula'
                      '\n'
                      '- deve ter no mínimo um (1) número'
                      '\n'
                      '- deve ter no mínimo caractere especial',
                ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  // validator: (value) => _emailClass.validateEmail(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: 'email',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _setName(),
                  label: 'criar',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: UiPadding.large * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
