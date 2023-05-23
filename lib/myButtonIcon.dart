import 'package:flutter/material.dart';

class myButtonIcon extends StatelessWidget {
  var name;
  var buttonColor;
  String image = '';
  bool isImage;


  myButtonIcon(this.name, this.buttonColor, this.isImage);
  

  @override
  Widget build(BuildContext context) {
    image = 'icons/$name.png';


    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        width: 20,
        child: Center(
            child: (
              isImage ?
              Image.asset(image, height: 20, color: Color.fromARGB(255, 0, 0, 0),) :
              Icon(Icons.backspace_outlined)
            )
           ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: buttonColor
        ),
      ),
    );
  }
}