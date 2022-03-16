import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({Key? key}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  Widget build(BuildContext context) {
    var cList = context.watch<ExpensesProvider>().allItemsList;
    var eList = context.watch<ExpensesProvider>().eList;
    var etList = context.watch<ExpensesProvider>().etList;
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    var totalEt = getAmountFormat(
      getSumOfEntrie(etList)
    );

    var totalEx = getAmountFormat(
      getSumOfExP(eList)
    );

    cList = cList.where((e) => e.category == cModel!.category).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            title: Text(cModel!.category),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    getAmountFormat(cModel.amount),
                    style: const TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children:[
                        PercentCircular(
                          percent: cModel.amount / getSumOfEntrie(etList), 
                          radius: 70, 
                          color: Colors.blue,
                          arcType: ArcType.HALF,
                        ),
                        Text(
                          'Absorbe de tus\nIngresos: $totalEt',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PercentCircular(
                          percent: cModel.amount / getSumOfExP(eList), 
                          radius: 70, 
                          color: Colors.red,
                          arcType: ArcType.HALF,
                        ),
                        Text(
                          'Representa de tus\n Gastos: $totalEx',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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

          SliverList(delegate: SliverChildBuilderDelegate(
            (context, i){
              var item = cList[i];
              return ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 40.0),
                    Positioned(
                      top: 16,
                      child: Text(item.day.toString())
                    )
                  ],
                ),
                title: PercentLinear(
                  percent: item.amount / cModel.amount,
                  color: item.color.toColor(),
                ),
                trailing: Text(
                  getAmountFormat(item.amount),
                  style: const TextStyle(
                    // fontSize: 18.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold
                  ),
                ),
              );
            },
            childCount: cList.length
          ))
        ],
      ),
    );
  }
}