
import 'package:exp_app/widgets/charts_page_wt/chart_line.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_pie.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_scatterplot.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: const Text('Gráfico'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Selector'),
                    Expanded(
                      // child: ChartLine()
                      // child: ChartPie()
                      child: ChartScatterPlot(),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              height: 40.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}