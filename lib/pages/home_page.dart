import 'package:exp_app/pages/balance_page.dart';
import 'package:exp_app/pages/charts_page.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_pager_wt/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    print('object');
    
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<UIProvider>();
    final _index = currentIndex.indexMenu;
    // final ll = context.select((UIProvider ui) => ui.indexMenu);


    switch(_index){
      case 0: 
        return const BalancePage();
      case 1:
        return const ChartsPage();
      default : 
        return const BalancePage();
    }
  }
}
