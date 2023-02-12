import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loggedIn = false;

  bool isLoggedIn() => _loggedIn;

  void login() async {

    var user=await  currentUser();

    if(user!= null){
      _loggedIn=true;
      notifyListeners();
    }else{
      _loggedIn=false;
      notifyListeners();
    }
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }

  Future<User?> currentUser() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? authentication =
    await account?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication?.idToken,
        accessToken: authentication?.accessToken);

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    return user;
    }
}
