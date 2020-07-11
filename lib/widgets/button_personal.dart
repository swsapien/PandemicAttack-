import 'package:flutter/material.dart';

class ButtonPersonal extends StatelessWidget{
  String titleText = "Navigate";
  final VoidCallback onPressed;
  double height;
  double width;
  
  ButtonPersonal({
      Key key,
      @required this.titleText,
      @required this.height,
      @required this.width, 
      @required this.onPressed,
  });

  
  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                      Color.fromRGBO(36, 229, 110, 1),
                      Color.fromRGBO(36, 229, 110, 1)
                    ],
            begin: FractionalOffset(0.2, 0.0),
            end: FractionalOffset(1, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp
            )
          ),
          child: Center(
            child:  Text(
              titleText,
              style: TextStyle(
                fontFamily: "8bitpusab",
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500
              )
            ),
          ),
        ),
      );
    
    return button;
  }
}