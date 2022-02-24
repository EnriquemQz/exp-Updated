import 'package:exp_app/pages/entries_details.dart';
import 'package:exp_app/pages/expenses_details.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/expenses_provider.dart';

class BackSheet extends StatelessWidget {
  const BackSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;

    _headers(String name, String amount, Color color){
      return Column(
        children:[
          Padding(
            padding: const EdgeInsets.only(top: 13.0, bottom: 5.0),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.5,
              ),
            )
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.5,
              color: color
            ),
          )
        ]
      );
    }
    return Container(
      height: 250.0,
      decoration: Constants.sheetBoxDecoration(
        Theme.of(context).primaryColorDark
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
                PageAnimationRoutes(
                  widget: const EntriesDetails(), 
                  ejex: -0.5, 
                  ejey: -0.5
                )
              );
            },
            child: _headers(
              'Ingresos', 
              getAmountFormat(getSumOfEntrie(etList)) ,
              Colors.green
            )),
          const VerticalDivider(
            thickness: 2.0,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                PageAnimationRoutes(
                  widget: const ExpensesDetails(), 
                  ejex: 0.5,
                  ejey: - 0.5
                )
              );
            },
            child: _headers(
              'Gastos', 
              getAmountFormat(getSumOfExP(eList)), 
              Colors.red
            )),
        ],
      ),
    );
  }
}