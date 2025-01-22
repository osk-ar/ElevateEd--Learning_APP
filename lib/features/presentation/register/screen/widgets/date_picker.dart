import 'package:flutter/material.dart';

Future<String?> getDateInput(BuildContext context) async {
  DateTime? pickedTime = await showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime(DateTime.now().year + 1),
    currentDate: DateTime.now(),
  );
  if (pickedTime != null) {
    String? date = pickedTime.toString().split(" ")[0];
    return date;
  }
  return null;
}
