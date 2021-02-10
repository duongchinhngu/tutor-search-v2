import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/repositories/transaction_repository.dart';
import 'package:tutor_search_system/states/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository transactionRepository;
  final EnrollmentRepository enrollmentRepository;
  TransactionCubit(this.transactionRepository, this.enrollmentRepository) : super(InitialTransactionState());

  //insert TuteeTransaction to DB ( in case MOMO transaction is successful); 
  // then insert enrollment to DB => connect tutee to couse as pending status
  Future completeFollowCourse(TuteeTransaction tuteeTransaction, Enrollment enrollment) async {
    try {
      //
      await transactionRepository.postTuteeTransaction(tuteeTransaction);
      //
      // await enrollmentRepository.postEnrollment(enrollment);
      emit(TransactionCompletedState());
    } catch (e) {
      emit(TransactionErrorState('$e'));
    }
  }
}