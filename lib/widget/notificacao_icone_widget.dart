import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class NotificacaoIconeWidget extends StatelessWidget {
  const NotificacaoIconeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 10,
      right: 10,
      child: RippleAnimation(
        color: UiCor.alerta,
        delay: Duration(milliseconds: 1000),
        repeat: true,
        minRadius: 6,
        ripplesCount: 3,
        duration: Duration(milliseconds: 3 * 1000),
        child: CircleAvatar(
          minRadius: 4,
          maxRadius: 4,
          backgroundColor: UiCor.alerta,
        ),
      ),
    );
  }
}
