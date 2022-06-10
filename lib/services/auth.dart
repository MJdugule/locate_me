import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locate_me/screens/authenticate/main_sign_in.dart';
import 'package:locate_me/screens/home/map_screen.dart';

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user == null) {
        print('No user');
      } else {
        final GoogleSignInAuthentication _googleAuth =
            await user.authentication;
        OAuthCredential _oAuth = GoogleAuthProvider.credential(
            accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const MapScreen())));

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(_oAuth);

        if (userCredential.user?.email != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const MapScreen())));
          print('Email not found');
        } else {
          print('Select your password');
        }
      }
    } catch (e) {
      print('Something went wrong: ' '${e.toString()}');
    }
  }

  Future<void> signInWithFacebook(context) async {
    final accessToken = await FacebookAuth.instance.accessToken;
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const MapScreen())));
    } else {
      print('not logged in');
    }
  }

  Future<bool> logOut(context) async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const MainSignIn())));
      return true;
    } catch (e) {
      print('Logged out');
      return false;
    }
  }
}
