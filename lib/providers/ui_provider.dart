
import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  int _bnbIndex = 0;
  int _selectedMonth = DateTime.now().month - 1;
  String _selectedChart = 'Gráfico Lineal';

  int get bnbIndex => _bnbIndex;
  set bnbIndex(int i){
    _bnbIndex = i;
    notifyListeners();
  }

  int get selectedMonth => _selectedMonth;
  set selectedMonth(int i){
    _selectedMonth = i;
    notifyListeners();
  }

  String get selectedChart => _selectedChart;
  set selectedChart(String s){
    _selectedChart = s;
    notifyListeners();
  }
}