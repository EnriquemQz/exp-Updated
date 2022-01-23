import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/add_expenses_wt/create_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/utils.dart';

class AdminCategory extends StatelessWidget {
  const AdminCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;

    return ListView.builder(
      itemCount: fList.length,
      itemBuilder: (context, i){
        var item = fList[i];
        return ListTile(
          leading: Icon(
            item.icon.toIcon(),
            size: 35.0,
            color: item.color.toColor()
          ),
          title: Text(item.category),
          trailing: const Icon(
            Icons.edit,
            size: 25.0,
          ),
          onTap: (){
            Navigator.pop(context);
            _createCategory(context, item);
          },
        );
      }
    );
  }

  _createCategory(BuildContext context, FeaturesModel fModel){
    var features = FeaturesModel(
      id: fModel.id,
      category: fModel.category,
      color: fModel.color,
      icon: fModel.icon
    );
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      context: context, 
      builder: (_) => CreateCategory(fModel: features)
    );
  }
}