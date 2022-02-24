import 'package:exp_app/models/entries_model.dart';
import 'package:intl/intl.dart';

import '../models/expenses_model.dart';
export 'package:exp_app/utils/math_operations.dart';


getAmountFormat(double amount){
  return NumberFormat.simpleCurrency().format(amount);
}

getSumOfExP(List<ExpensesModel> eList){
  double _eList;

  _eList = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return _eList;
}

getSumOfEntrie(List<EntriesModel> etList){
  double _etList;

  _etList = etList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return _etList;
}

getBalance(List<ExpensesModel> eList, List<EntriesModel> etList){
  double _balance;

  _balance = getSumOfEntrie(etList) - getSumOfExP(eList);
  return getAmountFormat(_balance);
}

