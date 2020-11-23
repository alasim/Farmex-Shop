import 'package:farmex_shop/official/user/ui/components/CustomShapeClipper.dart';
import 'package:flutter/material.dart';

const kLiteGeen = Color(0xff4cd137);
const kDeepGeen1 = Color(0xff44bd32);
const kLiteGeen1 = Color(0xff92ff1B); //#4cd137
const kDeepGeen = Color(0xff92D61B); //Color(0xff3a9e00)
const kExtraDeepGeen = Color(0xff39B54A); //Color(0xff3a9e00)
const kLiteOrange = Color(0xffFCa500);
const kDeepOrange = Color(0xffFC9000);

final customPaintGreen = MyCustomPaint(
  kLiteGeen,
  kDeepGeen,
  Colors.black87.withOpacity(.02),
  Colors.black.withOpacity(.01),
);

final customPaintOrange = MyCustomPaint(
  kDeepOrange,
  kLiteOrange,
  Colors.black87.withOpacity(.02),
  Colors.black.withOpacity(.01),
);

final greenTheme = {
  'detail': customPaintGreen, //only need for details page constructor
  'lite': kLiteGeen,
  'deep': kDeepGeen,
};

final orangeTheme = {
  'detail': customPaintOrange, //only need for details page constructor
  'lite': kLiteOrange,
  'deep': kDeepOrange,
};
