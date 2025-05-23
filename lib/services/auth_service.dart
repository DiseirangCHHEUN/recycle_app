import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:recycle_app/services/shared_pref.dart';

import 'database.dart';

class AuthService {
  signinWithGoogle() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential = await firebaseAuth
        .signInWithCredential(credential);
    final User? user = userCredential.user;
    await SharedPreferencesHelper().saveUserId(user!.uid);
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

    await DatabaseMethods().addUserInfo(userData, user.uid);
  }

  Future signOut() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await firebaseAuth.signOut();
    await googleSignIn.signOut();

    await SharedPreferencesHelper().clearUserData();
  }
}
