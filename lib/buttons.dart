import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final color;
 final textColor;
 final String buttonText;
 final buttonTapped;
 MyButton( { this.color, this.textColor, this.buttonText = "", this.buttonTapped} );

 @override
 Widget build(BuildContext context){
  return GestureDetector(
    onTap: buttonTapped,
    child: Padding(
      padding: const EdgeInsets.all(0.2),
      child: ClipRRect(
        child: Container(
          color: color,
          child: Center(
            child: Text(buttonText, 
                        style: TextStyle(fontSize: 20, color: Colors.black)
                       )
          )
        ) 
      )
    )
  );
 }
}