
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/icon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:exp_app/utils/utils.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';

class CreateCategory extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategory({Key? key, required this.fModel}) : super(key: key);

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {

  bool hasData = false;
  String stcCategory = '';    // static category

  @override
  void initState() {
    if(widget.fModel.id != null){
      stcCategory = widget.fModel.category;  //cacho el valor y no redibujo
      hasData = true;
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;
    final exProvider = context.read<ExpensesProvider>();

    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    Iterable<FeaturesModel> contain;

      contain = fList.where((e) => 
        e.category.toLowerCase() == widget.fModel.category.toLowerCase()
      );
    
    _addCategory(){
      if(contain.isNotEmpty){
        Fluttertoast.showToast(
          msg: 'Ya existe esa Categoría 🤷‍♂️',
          backgroundColor: Colors.red,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
      } else if(widget.fModel.category.isNotEmpty){
        exProvider.addNewFeature(
          widget.fModel
        );
         Fluttertoast.showToast(
          msg: 'Categoría creada con exito 👍',
          backgroundColor: Colors.green,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
        Navigator.pop(context);
      } else {
         Fluttertoast.showToast(
          msg: 'No olvides nombrar una categoría 🙃',
          backgroundColor: Colors.red,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
      }
    }

    _editCategory(){
      if(widget.fModel.category.toLowerCase() == stcCategory.toLowerCase()){
        exProvider.updateFeatures(
          widget.fModel
        );
         Fluttertoast.showToast(
          msg: 'Categoría editada 👍',
          backgroundColor: Colors.green,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
        Navigator.pop(context);
      } else if(contain.isNotEmpty){
         Fluttertoast.showToast(
          msg: 'Ya existe esa Categoría 🤷‍♂️',
          backgroundColor: Colors.red,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
      } else if(widget.fModel.category.isNotEmpty){
         exProvider.updateFeatures(
          widget.fModel
        );
        Fluttertoast.showToast(
          msg: 'Categoría editada 👍',
          backgroundColor: Colors.green,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: 'No olvides nombrar una categoría 🙃',
          backgroundColor: Colors.red,
          fontSize: 20.0,
          gravity: ToastGravity.CENTER
        );
      }
    }

    

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.only(bottom: viewInsets / 3),
              child: ListTile(
                trailing: const Icon(Icons.text_fields_outlined, size: 35.0),
                title: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: widget.fModel.category,
                  decoration: InputDecoration(
                    hintText: 'Nombra una categoría',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                  ),
                  onChanged: (txt) {
                    widget.fModel.category = txt;
                  },
                ),
              ),
            ),

            ListTile(
              onTap: () => _selectColor(),
              trailing: CircleColor(
                color: widget.fModel.color.toColor(), 
                circleSize: 35.0
              ),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).cardColor
                  ),
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: const Center(
                  child: Text(
                    'Color'
                  ),
                ),
              ),
            ),

            ListTile(
              onTap: () => _selectedIcon(),
              trailing: Icon(widget.fModel.icon.toIcon(), size: 35.0),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).cardColor
                  ),
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: const Center(
                  child: Text(
                    'Icono'
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Constants.customButton(
                      Colors.transparent,
                      Colors.red, 
                      'CANCELAR'
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      (hasData)
                      ? _editCategory()
                      : _addCategory();
                    },
                    child: Constants.customButton(
                      Colors.green,
                      Colors.transparent, 
                      'ACEPTAR'
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      )
    );
  }

  _selectColor(){
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context, 
      builder: (context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialColorPicker(
              selectedColor: widget.fModel.color.toColor(),
              physics: const NeverScrollableScrollPhysics(),
              circleSize: 50.0,
              onColorChange: (Color color){
                var hexColor = '#${color.value.toRadixString(16).substring(2,8)}';
                setState(() {
                  widget.fModel.color = hexColor;
                });
              },
              // allowShades: false,
              // iconSelected: Icons.category,
              // colors: fullMaterialColors
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Constants.customButton(
                Colors.green, 
                Colors.transparent, 
                'LISTO'
              ),
            )
          ],
        );
      }
    );
  }

  _selectedIcon(){
    final iconList = IconList().iconMap;

    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context, 
      builder: (cotext) {
        return SizedBox(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5
            ), 
            itemCount: iconList.length,
            itemBuilder: (context, i){
              var key = iconList.keys.elementAt(i);
              return GestureDetector(
                child: Icon(
                  key.toIcon(),
                  size: 30.0,
                  color: Theme.of(context).dividerColor,
                ),
                onTap: (){
                  setState(() {
                    widget.fModel.icon = key;
                    Navigator.pop(context);
                  });
                },
              );
            }
          ),
        );
      }
    );
  }
  
}