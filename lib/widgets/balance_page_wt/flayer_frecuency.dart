import 'package:exp_app/widgets/charts_page_wt/chart_line.dart';
import 'package:flutter/material.dart';

class FlayerFrecuency extends StatelessWidget {
  const FlayerFrecuency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 180.0,
      child: ChartLine(),
    );
  }
}