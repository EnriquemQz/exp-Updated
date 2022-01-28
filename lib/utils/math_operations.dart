import 'package:intl/intl.dart';
export 'package:exp_app/utils/math_operations.dart';


getAmountFormat(double amount){
  return NumberFormat.simpleCurrency().format(amount);
}