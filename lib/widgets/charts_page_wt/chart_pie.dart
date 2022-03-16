import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/utils.dart';

class ChartPie extends StatefulWidget {
  const ChartPie({Key? key}) : super(key: key);

  @override
  State<ChartPie> createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPie> {
  String catName = 'TOTAL';
  String catColor = '#388e3c';
  String catIcon = 'attach_money_outlined';
  double catAmount = 0.0;
  double expTotal = 0.0;
  int _index = -1;
  bool _animate = true;

  @override
  void initState() {
    super.initState();
    catAmount = context.read<ExpensesProvider>().eList 
      .map((e) => e.expense).fold(0.0, (a, b) => a + b);
    expTotal = context.read<ExpensesProvider>().eList 
      .map((e) => e.expense).fold(0.0, (a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    final gList = context.watch<ExpensesProvider>().grouptemsList;

    List<charts.Series<CombinedModel, String>> _series(int index){
      return [
        charts.Series<CombinedModel, String>(
          id: 'PieChart',
          domainFn: (v, i) => v.category,
          measureFn: (v, i) => v.amount,
          keyFn: (v, i) => v.icon,
          colorFn: (v, i) {
            var onTap = i == index;
            if(onTap == false){
              return charts.ColorUtil.fromDartColor(v.color.toColor());
            } else {
              return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
            }
          },
          labelAccessorFn: (v , i) 
          => '${(v.amount * 100 / expTotal).toStringAsFixed(2)}%',
          outsideLabelStyleAccessorFn: (v, i){
            var onTap = i == index;
            return charts.TextStyleSpec(
              fontSize: (onTap) ? 14 : 8,
              color: charts.ColorUtil
                .fromDartColor(Theme.of(context).dividerColor)
            );
          },
          data: gList
        )
      ];
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        charts.PieChart<String>(
          _series(_index),
          animate: _animate,
          animationDuration: const Duration(milliseconds: 800),
          defaultInteractions: true,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 45,
            strokeWidthPx: 0.0,
            arcRendererDecorators:
            [
              charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.outside,
                labelPadding: 2,
                showLeaderLines: true,
                leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                  length: 8,
                  color: charts.MaterialPalette.white,
                  thickness: 1
                ),
                // outsideLabelStyleSpec: const charts.TextStyleSpec(
                //   color: charts.MaterialPalette.white,
                //   fontSize: 8
                // ),
              )
            ]
          ),
          selectionModels: [
            charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model){
                if(model.hasDatumSelection){
                  setState(() {
                    _animate = false;
                    _index = model.selectedDatum[0].index!;

                    catIcon = model.selectedSeries[0]
                      .keyFn!(model.selectedDatum[0].index)
                      .toString();
                    catName = model.selectedSeries[0]
                      .domainFn(model.selectedDatum[0].index); 
                    catAmount = model.selectedSeries[0]
                      .measureFn(model.selectedDatum[0].index)
                      !.toDouble();
                    catColor = model.selectedSeries[0]
                      .colorFn!(model.selectedDatum[0].index)
                      .toString().replaceFirst(RegExp(r'ff'),'',6);
                  });
                }
              },
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Icon(
                catIcon.toIcon(),
                color: catColor.toColor(),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                catName
              )
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                getAmountFormat(catAmount)
              )
            ),
          ],
        )
      ],
    );
  }
}