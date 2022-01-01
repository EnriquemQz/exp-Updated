import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exp_app/providers/ui_provider.dart';


class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _readIndex = context.read<UIProvider>();
    final _watchIndex = context.watch<UIProvider>();

    return BottomNavigationBar(
      currentIndex: _watchIndex.indexMenu,
      onTap: (int i)  => _readIndex.indexMenu = i,
      elevation: 0.0,
      items: 
      const [
        BottomNavigationBarItem(label: 'Balance', icon: Icon(Icons.account_balance_outlined)),
        BottomNavigationBarItem(label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
        BottomNavigationBarItem(label: 'Configaración', icon: Icon(Icons.settings)),
      ]
    );
  }
}