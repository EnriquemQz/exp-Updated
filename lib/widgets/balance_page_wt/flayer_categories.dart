
import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_pie_flayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/utils.dart';


class FlayerCategories extends StatelessWidget {
  const FlayerCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    final gList = exProvider.grouptemsList;
    List<CombinedModel> limitList = [];
    bool hasLimit = false;

    if(gList.length >= 6){
      limitList = gList.sublist(0, 5);
      hasLimit = true;
    }

    if(limitList.length == 5){
      limitList.add(CombinedModel(
        category: 'Otros..',
        icon: 'otros',
        color: '#20634b'
      ));
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (hasLimit) ? limitList.length : gList.length,
                itemBuilder: (_, i){
                  var item = gList[i];
                  if(hasLimit == true) item = limitList[i];
                  
                  return GestureDetector(
                    onTap: (){
                      if(item.category == 'Otros..'){
                        uiProvider.bnbIndex = 1;
                        uiProvider.selectedChart = 'Gráfico Pie';
                      } else {
                        Navigator.pushNamed(
                        context, 
                        'cat_details',
                        arguments: item
                      );
                      }
                      
                    },
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      horizontalTitleGap: -10,
                      leading: Icon(
                        item.icon.toIcon(),
                        color: item.color.toColor(),
                      ),
                      title: Text(
                        item.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      // trailing: Text(
                      //   getAmountFormat(item.amount)
                      // ),
                    ),
                  );
                },
              ),
            ),
            
            const Expanded(
              flex: 3,
              child: SizedBox(
                height: 225.0,
                child: ChartPieFlayer(),
              )
            ),
          ],
        ),
        GestureDetector(
          onTap: (){
            uiProvider.bnbIndex = 1;
            uiProvider.selectedChart = 'Gráfico Pie';
          },
          child: const Align(
            alignment: Alignment.bottomRight,
            widthFactor: 4.5,
            child: Text(
              'DETALLES',
              style: TextStyle(
                fontSize: 12.0,
                letterSpacing: 1.5
              ),
            ),
          ),
        )
      ],
    );
  }
}