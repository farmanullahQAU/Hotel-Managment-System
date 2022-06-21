import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatelessWidget {

  final Widget child;
final Color color;
final Color borderColor;
final Color hoverColor;
  final VoidCallback onPressed;
  const MaterialButtonWidget({Key? key,required this.child,required this.onPressed,
  required this.borderColor,
  required this.color,required this.hoverColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(50),
           side: 
           BorderSide(color:borderColor)
           
                 
               ),
               color: color,
               hoverColor:hoverColor,
                            onPressed: onPressed,
                            child: child
                          );
  }
}