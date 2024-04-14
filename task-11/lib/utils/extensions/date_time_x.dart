import 'package:intl/intl.dart';

extension DateTimeX on DateTime{
  String toStringDateAndTime(){
    return DateFormat('yy.MM.dd в HH:mm', 'ru').format(this);
  }
}