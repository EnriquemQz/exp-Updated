import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/expenses_provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButton({Key? key, required this.cModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();

    return GestureDetector(
      onTap: (){

        if(cModel.amount != 0.00 && cModel.link != null){
          exProvider.addNewExpense(cModel);
          Fluttertoast.showToast(
            msg: 'Gasto agregado 👍',
            backgroundColor: Colors.green
          );
          Navigator.pop(context);
        } else if(cModel.amount == 0.0){
          Fluttertoast.showToast(
            msg: 'No olvides agregar un gasto',
            backgroundColor: Colors.red
          );
        } else {
          Fluttertoast.showToast(
            msg: 'No olvides seleccionar una categoría',
            backgroundColor: Colors.red
          );
        }
        
        
      },
      child: SizedBox(
        height: 70.0,
        width: 150.0,
        child: Constants.customButton(
         Colors.green, 
         Colors.white, 
         'GUARDAR'
        ),
      )
    );
  }
}