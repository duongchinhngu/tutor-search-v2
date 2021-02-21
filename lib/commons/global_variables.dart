library my_prj.global;

import 'package:intl/intl.dart';
import 'package:tutor_search_system/models/tutee.dart';
import 'package:tutor_search_system/models/tutor.dart';

// tutee id for all page can access; this will be reseted when login succeed
Tutee authorizedTutee;
//
//tutor id for all page can access;
//  this will be reseted when tutor login succeeded
//authorized tutor
Tutor authorizedTutor;
//
//filter keys for search course page

//
//default datetime
const defaultDatetime = '1990-01-01';
//default 'No select' variable
const DEFAULT_NO_SELECT = 'No select'; 
//
//date formatter
final dateFormatter = new DateFormat('yyyy-MM-dd');
//time formatter
final timeFormatter = new DateFormat('HH:mm');
