
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/person.dart';
import 'package:tutor_search_system/repositories/account_repository.dart';
import 'package:tutor_search_system/repositories/tutee_repository.dart';
import 'package:tutor_search_system/repositories/tutor_repository.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // RawUser userFromFirebaseUser(User user) {
  //   if (user != null) {
  //     return RawUser(
  //       id: int.parse(user.uid),
  //       email: user.email,
  //     );
  //   } else {
  //     return null;
  //   }
  // }

  // Stream<RawUser> get user {
  //   return _auth.authStateChanges().map(userFromFirebaseUser);
  // }

//login by googole auth by firebase
  Future<GoogleSignInAccount> handleSignInGoogle() async {
    try {
      return await _googleSignIn.signIn();

      // GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // UserCredential authResult = (await _auth.signInWithCredential(credential));

      // User currentUser =  _auth.currentUser;
      // String tokenResult = await currentUser.getIdToken();

      // return userFromFirebaseUser(currentUser);
    } catch (e) {
      print('this is error when sign in: $e');
    }
  }

  //load account by email; and then use RoleId to load Tutor or Tutee account info
  Future<Person> fetchPersonByEmail(String email) async {
    final account =
        await AccountRepository().fetchAccountByEmail(http.Client(), email);
    int roleId = account.roleId;
    if (roleId == 3) {
      return await TutorRepository()
          .fetchTutorByTutorEmail(http.Client(), account.email);
    } else if (roleId == 4) {
      return await TuteeRepository()
          .fetchTuteeByTuteeEmail(http.Client(), account.email);
    }
  }
}
