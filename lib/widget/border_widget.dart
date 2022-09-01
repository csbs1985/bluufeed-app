import 'package:flutter/widgets.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';

class BorderWiget extends StatelessWidget {
  const BorderWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiColor.border,
      height: UiSize.border,
    );
  }
}
