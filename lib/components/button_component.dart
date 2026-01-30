import 'package:flutter/material.dart';

import '../theme_data/fonts.dart';
import '../theme_data/palette.dart';

class ButtonComponent extends StatefulWidget {
  final Widget? icon;
  final String text;
  final double height;
  final double maxWidth;
  final Color? backgroundColor;
  final bool isBorderedButton;
  final Color? borderColor;
  final Function()? onPressed;

  const ButtonComponent({
    super.key,
    this.icon,
    required this.text,
    this.height = 58,
    this.maxWidth = double.infinity,

    this.onPressed,
  }) : isBorderedButton = false,
       borderColor = null,
       backgroundColor = Palette.primaryColor;

  const ButtonComponent.outlined({
    super.key,
    required this.text,
    this.height = 58,
    this.maxWidth = double.infinity,
    this.onPressed,
    this.icon,
  }) : isBorderedButton = true,
       backgroundColor = Colors.transparent,
       borderColor = Palette.primaryColor;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          color: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            side: widget.isBorderedButton
                ? BorderSide(color: Palette.primaryColor)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          // splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: widget.onPressed,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon!,
              if (widget.icon != null) const SizedBox(width: 8),
              Text(
                widget.text,
                style: CustomFontStyle.regularText.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
