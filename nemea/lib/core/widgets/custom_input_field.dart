import 'package:flutter/material.dart';
import 'package:nemea/utils/extensions/context.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    this.focusNode,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.helperText,
    this.prefixIcon,
    this.enabled = true,
    this.onChanged,
    required this.controller,
  });

  final String? labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? helperText;
  final bool enabled;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            ? Container(
                width: 24,
                height: 24,
                child: Align(
                  child: prefixIcon,
                ),
              )
            : null,
        labelText: labelText,
        helperText: helperText,
        fillColor: context.palette.cardColor,
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.palette.primaryColor,
            width: 5,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.palette.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
        ),
      ),
    );
  }
}
