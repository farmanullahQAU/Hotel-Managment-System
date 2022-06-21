import 'package:flutter/material.dart';

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
  final bool? isunique;
  final int? maxLines;

  final TextEditingController controller;

 const TxtField(
      {Key? key,
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
      maxLines: maxLines,

      validator: (val) => val == "" ? "*required" : null,

      onChanged: (value) =>
          onChanged != null ? onChanged!(value) : null,
      controller: controller,

      style: TextStyles.subtitle2?.copyWith(fontSize: 12, color: Colors.grey),

      decoration: InputDecoration(

        filled: true,


        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintTxt,

          fillColor: fillColor,
          
      ),
    );
  }
}