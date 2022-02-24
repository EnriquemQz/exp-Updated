import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({Key? key}) : super(key: key);

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  @override
  Widget build(BuildContext context) {
    final etList = context.watch<ExpensesProvider>().etList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desglose de Ingresos'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, i){
              return ListTile(
                title: Text(etList[i].entries.toString()),
              );
            },
            childCount: etList.length
          ))
        ],
      ),
    );
  }
}