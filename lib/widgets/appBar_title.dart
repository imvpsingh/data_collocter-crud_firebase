import 'package:flutter/material.dart';
import 'custom_text.dart';


Widget appBarTitle(String t1, String t2, double f1, double f2) {
  return   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CustomText(text: t1,fontSize: f1,color: const Color(0xff375e97),shadow: [],),
      CustomText(text: t2,fontSize: f2,color: const Color(0xfffb6542),shadow: [],),

    ],
  );
}