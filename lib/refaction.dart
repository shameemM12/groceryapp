import 'package:flutter/material.dart';

class insert extends StatelessWidget {
  final Widget? logo;
  final String? clue;
  final Widget? suffixIcon;
  final TextEditingController? store;
  final Color? fillColor;
  final String? Function(String?)? validators;

  insert(
      {super.key,
      this.logo,
      this.clue,
      this.store,
      this.suffixIcon,
      this.fillColor,
      this.validators});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: store,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIconColor: Colors.green[900],
        prefixIcon: logo,
        suffixIconColor: Colors.green[900],
        suffixIcon: suffixIcon,
        labelText: clue,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black)),
      ),
      validator: validators,
    );
  }
}
