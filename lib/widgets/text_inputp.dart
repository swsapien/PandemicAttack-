import 'package:flutter/material.dart';

class TextInputP extends StatefulWidget{
  int maxLines = 1;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;  
  final IconData iconData;
  TextInputP({
    Key key, 
    @required this.hintText, 
    @required this.inputType, 
    @required this.controller, 
    this.maxLines, 
    this.iconData
  });

  @override
  State<StatefulWidget> createState() {
    return _TextInputP();
  }

}

class _TextInputP extends State<TextInputP>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
       FocusScope.of(context).requestFocus(FocusNode());
      },
      child:  Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 20
          ),
          child: TextField(
            maxLength: 9,
            controller: widget.controller,
            keyboardType: widget.inputType,
            maxLines: widget.maxLines,
            style: TextStyle(
              fontSize: 15,
              fontFamily: "8bitpusab",
              color: Colors.blueGrey
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.black26),
              suffixIcon: Icon(widget.iconData),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black38
                ),
                borderRadius: BorderRadius.all(Radius.circular(1))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12
                ),
                borderRadius: BorderRadius.all(Radius.circular(1))
              ),
            ),
          ),
        )
      );
  }

}