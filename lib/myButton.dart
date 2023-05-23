import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  var name;
  var buttonColor;


  myButton(this.name, this.buttonColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        width: 20,
        child: Center(child: Text(
          name,
           style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500
           ),
           )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: buttonColor
        ),
      ),
    );
  }
}