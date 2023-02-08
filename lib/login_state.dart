import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loggedIn = false;

  bool isLoggedIn() => _loggedIn;

  void login() async {

    var user=await  signInWithGoogle();

    /*if(user!= null){
      _loggedIn=true;
      notifyListeners();
    }else{
      _loggedIn=false;
      notifyListeners();
    }*/
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      print("User signed in: ${user.uid}");
      _loggedIn=true;
      notifyListeners();
    } else {
      throw Exception('Failed to sign in with Google.');
    }
  }
}
