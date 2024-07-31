import 'package:flutter/material.dart';

class CustomPickers{
  CustomPickers(this.context);

  final BuildContext context;

  Future<DateTime?> date() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }
}