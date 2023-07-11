import 'package:eight_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: UiCor.overlay,
      body: Center(
        child: SizedBox(
          height: 200,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [Colors.white],
            strokeWidth: 2,
            backgroundColor: Colors.black,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
