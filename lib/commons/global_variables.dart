library my_prj.global;
import 'package:intl/intl.dart';

// tutee id for all page can access; this will be reseted when login succeed
int tuteeId = 0;

//tutor id for all page can access;
//  this will be reseted when tutor login succeeded
int tutorId = 1;

//filter keys for search course page

//default datetime
String defaultDatetime = '1990-01-01';

//date formatter
final dateFormatter = new DateFormat('yyyy-MM-dd');
//time formatter
final timeFormatter = new DateFormat('HH:mm');
