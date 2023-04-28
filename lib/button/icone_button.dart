import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class IconeButton extends StatefulWidget {
  const IconeButton({
    super.key,
    Function? callback,
    String? route,
    required String icon,
  })  : _callback = callback,
        _route = route,
        _icon = icon;

  final Function? _callback;
  final String? _route;
  final String _icon;

  @override
  State<IconeButton> createState() => _IconeButtonState();
}

class _IconeButtonState extends State<IconeButton> {
  void _onPressed() {
    setState(() {
      if (widget._route != null) {
        context.pushNamed("/${widget._route}");
        return;
      }

      widget._callback!(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: SvgPicture.asset(widget._icon),
      onPressed: () => _onPressed(),
    );
  }
}
