import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double height;
  final RegExp validationRegExp;
  final bool obscureText;
  final void Function(String?) onSaved;
  const CustomTextField({super.key, required this.hintText, required this.height, required this.validationRegExp, this.obscureText=false, required this.onSaved,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onSaved: onSaved,
        obscureText: obscureText,
        validator: (value) {
          if(value!=null && validationRegExp.hasMatch(value)) {
            return null;
          }
          return 'Enter a valid $hintText';
        },
        decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder()),
      ),
    );
  }
}
