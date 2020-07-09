import 'package:math_expressions/math_expressions.dart';

String getResult(String exp){
  Parser p = new Parser();
  ContextModel cm = new ContextModel();
  Expression ex = p.parse(exp);
  return ex.evaluate(EvaluationType.REAL, cm).toString();
}