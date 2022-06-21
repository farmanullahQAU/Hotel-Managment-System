import 'package:intl/intl.dart';

class ServiceProvider{


String formatDateTime(DateTime dateTime){

  return DateFormat.MEd().format(dateTime);
}
}