import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/notification.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/repositories/notification_repository.dart';
import 'package:tutor_search_system/repositories/tutee_transaction_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;
  NotificationCubit(this._repository)
      : super(InitialNotificationState());

  //get all active class by subject id
  Future getNotificationByEmail(String email) async {
    try {
      List<Notification> notificationes = await _repository
          .fetchNotificationByEmail(http.Client(), email);
      if (notificationes == null) {
        emit(NotificationNoDataState());
      } else {
        emit(NotificationListLoadedState(notificationes));
      }
    } catch (e) {
      emit(NotificationErrorState('$e'));
    }
  }
}
