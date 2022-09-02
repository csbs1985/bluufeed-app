import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class ButtonPublishWidget extends StatefulWidget {
  const ButtonPublishWidget({
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<ButtonPublishWidget> createState() => _ButtonPublishWidgetState();
}

class _ButtonPublishWidgetState extends State<ButtonPublishWidget> {
  late double _position = _borderSize;

  final double _borderSize = 4;
  final double _width = 60;
  final double _height = 28;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: _width,
        height: _height + _borderSize,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: _width,
                height: _height,
                decoration: const BoxDecoration(
                  color: UiColor.buttonBorder,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: _position,
              duration: const Duration(milliseconds: 10),
              child: Container(
                width: _width,
                height: _height,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  color: UiColor.button,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(
                  child: Text(
                    'Publicar',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTapUp: (_) {
        setState(() {
          _position = _borderSize;
          widget._callback(true);
        });
      },
      onTapDown: (_) {
        setState(() {
          _position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _position = _borderSize;
        });
      },
    );
  }
}
