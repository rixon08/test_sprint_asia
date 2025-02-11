import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDateToString(DateTime date){
  final dateFormat = DateFormat("dd/MM/yyyy");
  return dateFormat.format(date);
}

String convertTimeOfDayToString(TimeOfDay time){
  return "${time.hour}:${time.minute}";
}

