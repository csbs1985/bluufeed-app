import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/util/resume_util.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    required resume,
    double? top,
    double? bottom,
    double? width,
  })  : _resume = resume,
        _top = top,
        _bottom = bottom,
        _width = width;

  final _resume;
  final double? _bottom;
  final double? _top;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      padding: EdgeInsets.fromLTRB(0, _top ?? 0, 0, _bottom ?? 10),
      child: Row(
        children: [
          if (_resume['isAuthorized']) SvgPicture.asset(UiIcon.authorized),
          if (_resume['isAuthorized'])
            Text(' · ', style: Theme.of(context).textTheme.headline4),
          Text(
            resumeUitl(_resume),
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
