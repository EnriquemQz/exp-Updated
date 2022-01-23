
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/cupertino.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  int linkCombined = 0;

  addNewFeature(FeaturesModel newFeature) async {
    // final newFeature = FeaturesModel(
    //   category: category,
    //   color: color,
    //   icon: icon
    // );

    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    
    fList.add(newFeature);
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners(); 
  }

  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeatures(features);
    getAllFeatures();
    // notifyListeners();
  }
}