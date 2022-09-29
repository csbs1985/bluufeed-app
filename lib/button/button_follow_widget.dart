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
            width: 100,
          ),
        if (isFollow)
          Button3dWidget(
            callback: (value) {},
            label: 'deixar de seguir',
            style: ButtonStyleEnum.SECONDARY.value,
            width: 100,
          ),
      ],
    );
  }
}
