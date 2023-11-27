import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final buttonColor;
  final textColor;
  final buttonText;
  final buttonPress;

  MyButton({this.buttonColor,this.textColor,this.buttonText,this.buttonPress});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: buttonPress,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          color: buttonColor,
          child: Center(
            child: Text(buttonText, style: TextStyle(fontSize:8,fontWeight:FontWeight.bold, color: textColor )),
          ),
        ),
      ),
    );
  }

}