import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../textstyles.dart';

class TxtField extends StatelessWidget {
  final Function? onChanged;
  final double radius = 10;
  final double radius2 = 30;

  final String? lblTxt;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final String? hintTxt;
  final bool? ispassword;
  final List<TextInputFormatter>? inputFormatters;

  final Function? validator;
  final bool? isunique;
  final int? maxLines;
 final  TextInputType? textInputType;

  final TextEditingController controller;

 const TxtField(
      {Key? key,
      this.validator,
      this.textInputType,
      this.inputFormatters,
      this.lblTxt,
      this.onChanged,
      this.maxLines,
      this.prefixIcon,
      this.suffixIcon,
      this.fillColor,
      this.hintTxt,
      this.ispassword = false,
      this.isunique = false,
     required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
  keyboardType: textInputType,
      maxLines: maxLines,
inputFormatters: inputFormatters,

      validator: (val) => 
      
          validator!=null?
      
      validator!(val):null,
      
      
      
      // val == "" ? "*required".tr : null,

      onChanged: (value) =>
          onChanged != null ? onChanged!(value) : null,
      controller: controller,

      style: TextStyles.subtitle2?.copyWith(fontSize: 12, color: Colors.grey),

      decoration: InputDecoration(

        filled: true,


        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintTxt,
        labelText: lblTxt,

          fillColor: fillColor,
          
      ),
    );
  }
}