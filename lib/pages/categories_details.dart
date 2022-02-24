import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
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
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?;

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
                  children: const [
                    Text('Ingresos'),
                    Text('Gastos')
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
              return ListTile(
                title: Text(cList[i].category),
              );
            },
            childCount: cList.length
          ))
        ],
      ),
    );
  }
}