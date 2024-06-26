import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:i_dont_remember/enum/fonts.dart';
import 'package:i_dont_remember/enum/measures.dart';
import 'package:i_dont_remember/enum/palette.dart';

class RadioButton extends StatefulWidget {
  final String text;
  final Color color;
  final bool selected;
  final void Function()? onPressed;

  const RadioButton(
      {super.key,
      this.text = '',
      this.color = Palette.background,
      this.selected = false,
      this.onPressed});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  TextStyle get textStyle =>
      widget.selected ? Fonts.bold(size: 14) : Fonts.regular(size: 14);

  double get buttonBorderWidth => widget.selected ? 0 : 1;

  Color get buttonBackgroundColor =>
      widget.selected ? widget.color : Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: widget.color, width: buttonBorderWidth),
          backgroundColor: buttonBackgroundColor,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
              vertical: Measures.vButtonPadding,
              horizontal: Measures.hPadding),
        ),
        child: Text(widget.text, style: textStyle));
  }
}
