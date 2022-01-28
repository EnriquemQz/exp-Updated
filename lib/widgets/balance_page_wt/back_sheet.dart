import 'package:exp_app/pages/expenses_details.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';

class BackSheet extends StatelessWidget {
  const BackSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
          _headers('Ingresos', '\$ 3,500.00', Colors.green),
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
            child: _headers('Gastos', '\$ 1,500.00', Colors.red)),
        ],
      ),
    );
  }
}