import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/modal/history_opiton_modal.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ButtonFollowWidget extends StatefulWidget {
  const ButtonFollowWidget({super.key});

  @override
  State<ButtonFollowWidget> createState() => _ButtonFollowWidgetState();
}

class _ButtonFollowWidgetState extends State<ButtonFollowWidget> {
  final bool isFollow = false;

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return const HistoryOptionModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isFollow)
          Button3dWidget(
            callback: (value) {},
            label: 'seguir',
            style: ButtonStyleEnum.PRIMARY.value,
            width: 80,
          ),
        // if (isFollow)
        Button3dWidget(
          callback: (value) {},
          label: 'deixar de seguir',
          style: ButtonStyleEnum.SECONDARY.value,
          width: 140,
        ),
        IconButton(
          icon: SvgPicture.asset(UiIcon.option),
          onPressed: () => _openModal(context),
        ),
      ],
    );
  }
}
