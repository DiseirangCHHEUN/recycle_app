import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recycle_app/services/shared_pref.dart';

import 'database.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final sharedPreferences = SharedPreferencesHelper();
  Future<bool> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Check if user cancel signin process
      if (googleSignInAccount == null) {
        return false; // User cancelled
      }

      // Get authentication token
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // create a firebase credential using the token from google
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // get user info
      final UserCredential userCredential = await firebaseAuth
          .signInWithCredential(authCredential);
      final User? user = userCredential.user;

      if (user == null) {
        print("Firebase user is null after sign-in.");
        return false;
      }

      // save user info to sharedpreferences
      await SharedPreferencesHelper().saveUserId(user.uid);
      await SharedPreferencesHelper().saveUserName(user.displayName!);
      await SharedPreferencesHelper().saveUserEmail(user.email!);
      await SharedPreferencesHelper().saveUserImage(user.photoURL!);

      Map<String, dynamic> userData = {
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'points': 0,
      };

      // Check if user already exists
      bool existingUser = await DatabaseMethods().checkUserExists(user.uid);

      if (!existingUser) {
        await DatabaseMethods().addUserInfo(userData, user.uid);
        print("New user added to database.");
      } else {
        print("User already exists in database.");
      }

      await firebaseAuth.signInWithCredential(authCredential);
      return true; // Sign-In successful
    } on FirebaseAuthException catch (e) {
      print("Error : $e");
      return false;
    }
  }

  Future signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    await sharedPreferences.clearUserData();
  }
}
