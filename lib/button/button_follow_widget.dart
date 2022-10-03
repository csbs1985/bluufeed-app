import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/modal/perfil_option_modal.dart';
import 'package:bluuffed_app/model/following_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/following_service.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ButtonFollowWidget extends StatefulWidget {
  const ButtonFollowWidget({required Map<String, dynamic> perfil})
      : _perfil = perfil;

  final Map<String, dynamic> _perfil;

  @override
  State<ButtonFollowWidget> createState() => _ButtonFollowWidgetState();
}

class _ButtonFollowWidgetState extends State<ButtonFollowWidget> {
  final FollowingService followingService = FollowingService();

  bool isAuthor() {
    return currentUser.value.first.id == currentUserId.value ? true : false;
  }

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return const PerfilOptionModal();
      },
    );
  }

  void _toggleFollowing() {
    followingService.toggleFollowing(context, {
      'id': widget._perfil['id'],
      'name': widget._perfil['name'],
      'date': widget._perfil['date'],
    });

    _getIsFollowing();
  }

  void _getIsFollowing() {
    currentIsFollowing.value = !currentIsFollowing.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIsFollowing,
      builder: (BuildContext context, bool following, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button3dWidget(
              callback: (value) => _toggleFollowing(),
              label: following ? 'deixar de seguir' : 'seguir',
              style: following
                  ? ButtonStyleEnum.SECONDARY.value
                  : ButtonStyleEnum.PRIMARY.value,
              width: MediaQuery.of(context).size.width / 2,
            ),
            if (!isAuthor())
              IconButton(
                icon: SvgPicture.asset(UiIcon.option),
                onPressed: () => _openModal(context),
              ),
          ],
        );
      },
    );
  }
}
