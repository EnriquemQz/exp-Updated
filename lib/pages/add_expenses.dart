
import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/add_expenses_wt/bs_num_keyboard.dart';
import 'package:exp_app/widgets/add_expenses_wt/comment_box.dart';
import 'package:exp_app/widgets/add_expenses_wt/date_picker.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BSNumKeyboard(cModel: cModel),   // Modificar aqui tmb
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                Theme.of(context).primaryColorDark
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePicker(cModel: cModel),
                  const Text('Seleccionar Categoría'),
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          print('Gasto: ${cModel.amount}');
                          print('Fecha: ${cModel.year}/${cModel.month}/${cModel.day}');
                          print('Comentario: ${cModel.comment}');
                        },
                        child: const Text('Botón Done')))
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}