import 'package:flutter/material.dart';

extension StringX on String{
  Color hexToColor(){
    return fromHexString(this);
  }

  Color fromHexString(String input) {
    String normalized = input.replaceFirst('#', '');
    if (normalized.length == 6) {
      normalized = 'FF$normalized';
    }
    if (normalized.length !=  8) {
      return Colors.transparent;
    }
    final int? decimal = int.tryParse(normalized, radix: 16);
    return decimal == null ? Colors.transparent : Color(decimal);
  }
}
