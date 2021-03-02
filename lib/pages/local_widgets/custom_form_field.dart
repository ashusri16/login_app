import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginapp/utils/colors.dart';

class CustomFormField extends StatefulWidget {
  final String fieldName;
  final Widget prefixIcon;
  final Function(String) onChanged;
  final Function(String) validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatter;
  const CustomFormField(
      {Key key,
      this.fieldName,
      this.onChanged,
      this.inputFormatter,
      this.obscureText: false,
      this.prefixIcon,
      this.validator,
      this.keyboardType})
      : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black,
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: obscureText
                        ? Icon(
                            Icons.remove_red_eye,
                          )
                        : Icon(Icons.not_interested_outlined),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
            hintText: widget.fieldName,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.primaryColor, width: 2)),
          ),
          inputFormatters: widget.inputFormatter,
          keyboardType: widget.keyboardType,
          obscureText: obscureText,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Opensans',
              fontWeight: FontWeight.w600),
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ),
    );
  }
}
