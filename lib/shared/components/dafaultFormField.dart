import 'package:flutter/material.dart';

class defaultFormField extends StatelessWidget {
  @required
  TextEditingController controller;
  @required
  TextInputType type;
  @required
  String label;
  @required
  Widget prefix;
  Widget suffix;
  bool obscuretext;
  @required
  Function validator;
  Function onTap;
  Function onChanged;
  Function onFieldSubmitted;

  defaultFormField(
      {this.type,
      this.controller,
      this.label,
      this.prefix,
      this.suffix,
      this.obscuretext = false,
      this.validator,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      obscureText: obscuretext,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
