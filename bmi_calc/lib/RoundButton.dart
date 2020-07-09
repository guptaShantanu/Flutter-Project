import 'package:flutter/material.dart';
import 'constant.dart';


class RoundIconButton extends StatelessWidget {

  final IconData child;
  final Function onPress;

  RoundIconButton({this.child,this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      child: Icon(child),
      constraints: BoxConstraints.tightFor(width: 56.0,height: 56.0),
      shape: CircleBorder(),
      fillColor: active,
      elevation: 7.0,
      disabledElevation: 7.0,
    );
  }
}

