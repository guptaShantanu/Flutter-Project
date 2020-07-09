import 'package:flutter/material.dart';
import 'input_page.dart';
import 'constant.dart';
void main() => runApp(MaterialApp(
  theme: ThemeData.dark()
      .copyWith(primaryColor: inActive, scaffoldBackgroundColor: inActive),

  home: MyApp(),
));

