import 'package:flutter/material.dart';
import 'package:virusapp/widgets/text_inputp.dart';

class FormGeneric extends StatefulWidget{
  String hintTextPrimary;
  final TextEditingController controllerTitleBook;
  FormGeneric({
    Key key, 
    @required this.hintTextPrimary,
    @required this.controllerTitleBook,
  });
  @override
  State<StatefulWidget> createState() {
    return _FormGeneric();
  }

}

class _FormGeneric extends State<FormGeneric>{

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
         Container(
          margin: EdgeInsets.only(
            top: 30,
            bottom: 20
          ),
          child: TextInputP(
            hintText: widget.hintTextPrimary, 
            inputType: null, 
            controller: widget.controllerTitleBook,
            maxLines: 1
          ),
        ),        
      ]
    );
  }
}