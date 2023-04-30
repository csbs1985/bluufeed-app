import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

class ScrollIndicador extends StatefulWidget implements PreferredSizeWidget {
  ScrollIndicador({
    super.key,
    required double scroll,
  }) : _scroll = scroll;

  double _scroll;

  @override
  _ScrollIndicadorState createState() => _ScrollIndicadorState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ScrollIndicadorState extends State<ScrollIndicador> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        setState(() {
          widget._scroll = scrollNotification.metrics.pixels /
              scrollNotification.metrics.maxScrollExtent;
        });
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Container(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
            ),
            Positioned(
              left: 0,
              right: (1 - widget._scroll) * 100,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: UiCor.terceiro,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
