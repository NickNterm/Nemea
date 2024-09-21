import 'package:flutter/material.dart';
import 'package:nemea/utils/extensions/context.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.state = ButtonState.enabled,
    this.type = ButtonType.primary,
    this.height = 60,
    this.width = double.infinity,
  });

  final String text;
  final VoidCallback onPressed;
  final ButtonState state;
  final ButtonType type;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: state == ButtonState.disabled ? 0.5 : 1,
      child: IgnorePointer(
        ignoring: state == ButtonState.disabled,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: type.color(context),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: type.color(context),
            ),
            height: height,
            width: width,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onPressed,
              child: Center(
                child: Visibility(
                  visible: state != ButtonState.loading,
                  child: Text(
                    text,
                    style: context.textStyles.body1.copyWith(
                      color: context.palette.compTextColor,
                    ),
                  ),
                  replacement: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: context.palette.compTextColor,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonState {
  enabled,
  disabled,
  loading,
}

enum ButtonType {
  primary,
  secondary,
  cancel;

  Color color(BuildContext context) {
    switch (this) {
      case ButtonType.primary:
        return context.palette.primaryColor;
      case ButtonType.secondary:
        return context.palette.secondaryColor;
      case ButtonType.cancel:
        return Colors.red;
    }
  }
}
