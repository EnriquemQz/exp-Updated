

import 'package:flutter/cupertino.dart';

class Constants {
  
  static sheetBoxDecoration(Color color){
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0)
      )
    );
  }
}