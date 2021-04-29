import 'package:tutor_search_system/models/membership.dart';

abstract class MembershipState {}

class MembershipLoadingState extends MembershipState {}

class MembershipErrorState extends MembershipState {
  final String errorMessage;

  MembershipErrorState(this.errorMessage);
}

class MembershipLoadedState extends MembershipState {
  final Membership membership;

  MembershipLoadedState(this.membership);
}

class MembershipListLoadedState extends MembershipState {
  final List<Membership> memberships;

  MembershipListLoadedState(this.memberships);
}

class MembershipNoDataState extends MembershipState {}
