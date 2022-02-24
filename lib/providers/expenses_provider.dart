
import 'package:exp_app/models/entries_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_expenses.dart';
import 'package:exp_app/providers/db_features.dart';


class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];   // features
  List<ExpensesModel> eList = [];   // expenses
  List<CombinedModel> cList = []; 
  List<EntriesModel> etList = [];

 
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

  addNewEntrie(CombinedModel cModel) async {
    var entries = EntriesModel(
      year: cModel.year,
      month: cModel.month,
      day: cModel.day,
      comment: cModel.comment,
      entries: cModel.amount
    );

    final id = await DBExpenses.db.addEntries(entries);
    entries.id = id;
    etList.add(entries);
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

  getEntriesByDate(int month, int year) async {
    final response = await DBExpenses.db.getEntriesByDate(month, year);
    etList = [...response];
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
            link: x.link,
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

  List<CombinedModel> get grouptemsList {
    List<CombinedModel> _cModel = [];

    for(var x in eList){
      for(var y in fList){
        if(x.link == y.id){

          double _amount = eList.where((e) => e.link == y.id)
            .fold(0.0, (a, b) => a + b.expense);

          _cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            amount: _amount,

          ));
        }
      }
    }
    
    var encode = _cModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    _cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [..._cModel];
  }

}