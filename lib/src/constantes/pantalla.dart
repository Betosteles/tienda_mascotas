import 'package:flutter/widgets.dart';

double calculateHalfScreenWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double halfScreenWidth = screenWidth / 2;
  return halfScreenWidth;
}