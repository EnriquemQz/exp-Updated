import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentLinear extends StatelessWidget {
  final double percent;
  final Color color;
  const PercentLinear(
    {
      Key? key,
      required this.percent,
      required this.color
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      lineHeight: 16.0,
      percent: percent,
      barRadius: const Radius.circular(10.0),
      // progressColor: color,
      linearGradient: LinearGradient(
        colors: [
          Colors.grey,
          color,
          color
        ]
      ),
      center: Text(
        '${(percent * 100).toStringAsFixed(2)}%',
        style: const TextStyle(
          fontSize: 12.0
        ),
      ),

    );
  }
}

class PercentCircular extends StatelessWidget {
  final double percent;
  final double radius;
  final Color color;
  final ArcType arcType;
  
  const PercentCircular(
    {
      Key? key,
      required this.percent,
      required this.radius, 
      required this.color,
      required this.arcType
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _percent = percent;

    if(_percent > 1){
      _percent = 1;
    }

    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      percent: _percent,
      radius: radius,
      progressColor: color,
      arcType: arcType,
      backgroundWidth: 0.0,
      lineWidth: 12.0,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${(_percent * 100).toStringAsFixed(0)}%',
        style: const TextStyle(
          fontSize: 25.0
        ),
      ),
    );
  }
}



