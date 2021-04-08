import 'package:intl/intl.dart';
import 'package:tutor_search_system/models/tutee.dart';
// import 'package:tutor_search_system/models/tutee.dart';
import 'package:tutor_search_system/models/tutor.dart';

//---------------------user authentication variables------------------------------------------------------
// tutee id for all page can access; this will be reseted when login succeed

Tutee authorizedTutee = Tutee(
  id: 17,
  status: 'Active',
  fullname: 'Nguyen Trung Huy',
  gender: 'Male',
  birthday: '30-12-2998',
  email: 'huyntse63450@fpt.edu.vn',
  phone: '0393769476',
  avatarImageLink:
      'https://firebasestorage.googleapis.com/v0/b/tutor-search-project.appspot.com/o/successful-college-student-lg.png?alt=media&token=d66ef0a5-8c8c-4f05-934a-b96f0585c264',
  address: 'dai hoc bach khoa ho chi minh',
  roleId: 4,
);

//
//tutor id for all page can access;
//  this will be reseted when tutor login succeeded
//authorized tutor
Tutor authorizedTutor = Tutor(
  id: 1,
  educationLevel: 'University',
  school: 'FPT University',
  points: 128,
  membershipId: 19,
  status: 'Active',
  description:
      'is an Australian actor. He first rose to prominence in Australia playing Kim Hyde in the Australian television series Home and Away (2004–07) before beginning a film career in Hollywood. Hemsworth is best known for playing Thor in eight Marvel Cinematic Universe films, beginning with Thor (2011) and appearing most recently in Avengers: Endgame (2019), which established him as one of the leading and highest-paid actors in the world.',
  fullname: 'Duong Chinh Ngu',
  gender: 'male',
  birthday: '30-12-1998',
  email: 'duongchinhngu@gmail.com',
  phone: '0869623222',
  avatarImageLink:
      'https://scontent.fsgn2-6.fna.fbcdn.net/v/l/t1.0-9/154110299_1894151794070794_6102979715824123532_o.jpg?_nc_cat=110&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=aTzhxaTwq7QAX8XYG3M&_nc_ht=scontent.fsgn2-6.fna&oh=9fc99fc6f751faa186d561093817fa96&oe=607014E8',
  address: '100/40/18A Dinh Tien Hoang, 1st ward, Binh Thanh District, HCMC',
  socialIdUrl:
      'https://firebasestorage.googleapis.com/v0/b/tutor-search-project.appspot.com/o/142427098_3564214927024559_8940499895208575287_n.jpg?alt=media&token=25478224-42a9-4e50-a796-07c1fc94a413',
  roleId: 3,
  confirmedDate: '05-04-2021',
  createdDate: '05--04-2021',
);
//

//-------------------------------------orther common variables----------------------------------------------
//default datetime
const defaultDatetime = '1990-01-01';
//default 'No select' variable
const DEFAULT_NO_SELECT = 'No select';
//date formatter
final dateFormatter = new DateFormat('yyyy-MM-dd');
//time formatter
final timeFormatter = new DateFormat('HH:mm');
//--------------------------------------------------------------------------------------------------------
const feeRangeContent1 = 'Below \$25';
const feeRangeContent2 = '\$25 - \$50';
const feeRangeContent3 = 'Above \$50';
//gender constants

const GENDER_MALE = 'Male';
const GENDER_FEMALE = 'Female';

// -------------------------course status variables--------------------
class CourseConstants {
  static const ACTIVE_STATUS = 'Active';
  static const UNPAID_STATUS = 'Unpaid';
  static const ACCEPTED_STATUS = 'Accepted';
  static const DENIED_STATUS = 'Denied';
  static const INACTIVE_STATUS = 'Inactive';
  static const PENDING_STATUS = 'Pending';
  static const ONGOING_STATUS = 'Ongoing';
}

// -------------------------enrollment status variables--------------------
class EnrollmentConstants {
  static const ACCEPTED_STATUS = 'Accepted';
  static const UNPAID_STATUS = 'Unpaid';
  static const ACTIVE_STATUS = 'Active';
  static const DENIED_STATUS = 'Denied';
  static const PENDING_STATUS = 'Pending';
}

//--------------------
class StatusConstants {
  static const ACTIVE_STATUS = 'Active';
  static const INACTIVE_STATUS = 'Inactive';
}
