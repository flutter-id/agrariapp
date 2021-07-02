import 'package:flutter/material.dart';
import 'modules/layout/layout_screen.dart';
import 'constants/string_constant.dart';

void main() => runApp(Agraria());

class Agraria extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: LayoutScreen(),
    );
  }
}
