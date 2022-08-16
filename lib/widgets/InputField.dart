import 'package:flutter/material.dart';

class InputField extends StatelessWidget{

  final TextEditingController inputController;
  final TextInputType inputType;
  final String hintText;
  final bool withValidator;
  final FormFieldValidator? validator;
  final Widget? suffixIcon;


   InputField(
      this.inputController, this.inputType, this.hintText, this.withValidator,{this.validator, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      keyboardType: inputType,
      decoration:  InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        // labelText:  labelText,
        labelStyle: const TextStyle(
          color: Color.fromRGBO(120, 148, 150, 0.8),
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(120, 148, 150, 0.8),
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          this.withValidator?
              validator:
              (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter $hintText';
        } else {
          return null;
        }
      },
    );
  }


}