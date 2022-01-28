
import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_expenses.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];
 
  /* 
    ---- Functions to insert ----
  */

  addNewExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
      link: cModel.link,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      expense: cModel.amount
    );

    final id = await DBExpenses.db.addExpense(expenses);
    expenses.id = id;
    eList.add(expenses);
    notifyListeners();
  }

  
  addNewFeature(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    fList.add(newFeature);
    notifyListeners();
  }

  /* 
    ---- Functions to read ----
  */

  getExpensesByDate(int month, int year) async {
    final response = await DBExpenses.db.getExpenseByDate(month, year);
    eList = [...response];
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners(); 
  }

  /* 
    ---- Functions to edit ----
  */

  updateExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
      id: cModel.id,
      link: cModel.link,
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      expense: cModel.amount
    );
    await DBExpenses.db.updateExpenses(expenses);
    notifyListeners();
  }

  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeatures(features);
    getAllFeatures();
  }

  /* 
    ---- Functions to delete ----
  */

  deleteExpense(int id) async {
    await DBExpenses.db.deleteExpenses(id);
    notifyListeners();
  }


  /*
    ---- Getters to combined List ----
  */

  List<CombinedModel> get allItemsList {
    List<CombinedModel> _cModel = [];

    for(var x in eList){
      for(var y in fList){
        if(x.link == y.id){
          _cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            id: x.id,
            amount: x.expense,
            comment: x.comment,
            year: x.year,
            month: x.month,
            day: x.day
          ));
        }
      }
    }
    return cList = [..._cModel];
  }



}