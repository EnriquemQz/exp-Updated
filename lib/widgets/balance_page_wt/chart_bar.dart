import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChartBar extends StatelessWidget {
  const ChartBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0;
    double totalEt = 0;

    totalExp = getSumOfExP(eList);
    totalEt = getSumOfEntrie(etList);

    final data = [
      OrdinalSales('Ingresos', totalEt, Colors.green),
      OrdinalSales('Gastos', totalExp, Colors.red)
    ];

    List<charts.Series<OrdinalSales, String>> seriesList = [
      charts.Series<OrdinalSales, String>(
        id: 'Balance',
        domainFn: (v,i) => v.name,
        measureFn: (v,i) => v.amount,
        colorFn: (v,i) => charts.ColorUtil.fromDartColor(v.color),
        data: data
      )
    ];


    return SizedBox(
      child: charts.BarChart(
        seriesList,
        defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(50)
        ),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec()
        ),
      ),
    );
  }
}

class OrdinalSales {
  String name;
  double amount;
  Color color;

  OrdinalSales(this.name, this.amount, this.color);
}