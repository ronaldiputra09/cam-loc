import 'package:camera_geo/app/data/themes.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String hint;
  final bool obsecureText;
  final iconPrefix;
  final iconSuffix;
  final color;
  final TextEditingController? controller;

  const FormWidget({
    super.key,
    required this.hint,
    this.obsecureText = false,
    this.iconPrefix,
    this.iconSuffix,
    this.color,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: "${hint}",
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color ?? primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: InputBorder.none,
          prefixIcon: iconPrefix,
          prefixIconColor: color ?? primaryColor,
          suffixIcon: iconSuffix,
          suffixIconColor: color ?? primaryColor,
        ),
      ),
    );
  }
}
