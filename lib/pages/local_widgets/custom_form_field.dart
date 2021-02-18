import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String fieldName;
  final Function(String) onChanged;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatter;
  const CustomFormField(
      {Key key,
      this.fieldName,
      this.onChanged,
      this.inputFormatter,
      this.obscureText: false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
          border: Border.all(
            width: 1,
          ),
        ),
        child: TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 18),
            border: InputBorder.none,
            hintText: this.fieldName,
          ),
          inputFormatters: this.inputFormatter,
          onChanged: this.onChanged,
          validator: (value) {
            if (value.isEmpty) return "please  enter $fieldName";
            return null;
          },
        ),
      ),
    );
  }
}
