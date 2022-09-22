import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class IconWidget extends StatefulWidget {
  const IconWidget({
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
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
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
    return GestureDetector(
      child: SvgPicture.asset(widget._icon),
      onTap: () => _onPressed(),
    );
  }
}
