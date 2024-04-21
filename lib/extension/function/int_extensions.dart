import 'package:flutter/material.dart';
import 'package:i_dont_remember/enum/fonts.dart';
import 'package:i_dont_remember/enum/measures.dart';
import 'package:i_dont_remember/enum/palette.dart';

extension IntExtensions on int {
  String toModifierString() => '${this < 0 ? ' ' : '+'}$this ';

  String toSignString() => this < 0 ? '-' : '+';

  Duration elapsedTime() =>
      DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(this));
}
