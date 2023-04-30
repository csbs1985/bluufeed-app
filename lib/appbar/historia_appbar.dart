import 'package:bluufeed_app/widget/scroll_indicador.dart';
import 'package:flutter/material.dart';

class HistoriaAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HistoriaAppbar({
    super.key,
    required double scroll,
  }) : _scroll = scroll;

  final double _scroll;

  @override
  State<HistoriaAppbar> createState() => _HistoriaAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HistoriaAppbarState extends State<HistoriaAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      bottom: ScrollIndicador(scroll: widget._scroll),
    );
  }
}
