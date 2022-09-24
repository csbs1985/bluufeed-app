import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonFollowWidget extends StatefulWidget {
  const ButtonFollowWidget({super.key});

  @override
  State<ButtonFollowWidget> createState() => _ButtonFollowWidgetState();
}

class _ButtonFollowWidgetState extends State<ButtonFollowWidget> {
  final bool isFollow = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFollow)
          Button3dWidget(
            callback: (value) {},
            label: 'seguir',
            style: ButtonStyleEnum.PRIMARY.value,
            size: ButtonSizeEnum.MEDIUM.value,
            padding: 32,
          ),
        if (isFollow)
          Button3dWidget(
            callback: (value) {},
            label: 'deixar de seguir',
            style: ButtonStyleEnum.SECONDARY.value,
            size: ButtonSizeEnum.MEDIUM.value,
            padding: 32,
          ),
        Button3dWidget(
          callback: (value) {},
          label: 'bloquear',
          style: ButtonStyleEnum.SECONDARY.value,
          size: ButtonSizeEnum.MEDIUM.value,
          padding: 32,
        ),
        Button3dWidget(
          callback: (value) {},
          label: 'denunciar',
          style: ButtonStyleEnum.SECONDARY.value,
          size: ButtonSizeEnum.MEDIUM.value,
          padding: 32,
        ),
      ],
    );
  }
}
