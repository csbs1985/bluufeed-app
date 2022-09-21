import 'package:flutter/cupertino.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';

class SpaceXLargeWidget extends StatefulWidget {
  const SpaceXLargeWidget({super.key});

  @override
  State<SpaceXLargeWidget> createState() => _PaddingXLagerWidgetState();
}

class _PaddingXLagerWidgetState extends State<SpaceXLargeWidget> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: UiPadding.xLarge);
  }
}
