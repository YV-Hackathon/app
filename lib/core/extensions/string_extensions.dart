import 'package:flutter/material.dart';

extension StringExtensions on String {
  // Validation
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isPhoneNumber {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(this);
  }

  bool get isUrl {
    return RegExp(r'^https?:\/\/').hasMatch(this);
  }

  bool get isStrongPassword {
    return length >= 8 &&
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(this);
  }

  // Formatting
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get removeSpaces => replaceAll(' ', '');

  String get removeSpecialCharacters =>
      replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');

  // Truncation
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  // Null safety
  bool get isNullOrEmpty => isEmpty;
  bool get isNotNullOrEmpty => isNotEmpty;

  // Text styling
  TextSpan toTextSpan({TextStyle? style, VoidCallback? onTap}) {
    return TextSpan(
      text: this,
      style: style,
      recognizer:
          onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null,
    );
  }
}
