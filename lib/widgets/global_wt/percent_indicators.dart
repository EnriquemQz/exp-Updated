import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentCircular extends StatelessWidget {
  const PercentCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30
    );
  }
}