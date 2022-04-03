

import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/add_expenses_wt/bs_category.dart';
import 'package:exp_app/widgets/add_expenses_wt/bs_num_keyboard.dart';
import 'package:exp_app/widgets/add_expenses_wt/comment_box.dart';
import 'package:exp_app/widgets/add_expenses_wt/date_picker.dart';
import 'package:exp_app/widgets/add_expenses_wt/save_button.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var viewInsets = MediaQuery.of(context).viewInsets.bottom;

    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel = 
      ModalRoute.of(context)!.settings.arguments as CombinedModel?;

      if(editCModel != null){
        cModel = editCModel;
        hasData = true;
      }
    

    return Scaffold(
      appBar: AppBar(
        title: (hasData) ? const Text('Editar Gasto') : const Text('Agregar Gasto'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BSNumKeyboard(cModel: cModel),  
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                Theme.of(context).primaryColorDark
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatePicker(cModel: cModel),
                    BSCategory(cModel: cModel),
                    CommentBox(cModel: cModel),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80.0),
                      child: Center(
                        child: SaveButton(
                          cModel: cModel,
                          hasData: hasData,
                        )
                      )
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}