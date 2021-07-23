import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:growbymargin/Screens/EmailVerification.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:page_transition/page_transition.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: Home(), type: PageTransitionType.bottomToTop));
      });
    } on FirebaseAuthException catch (e) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message!),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  String get uID {
    try {
      final uid = (FirebaseAuth.instance.currentUser)!.uid;
      return uid;
    } catch (e) {
      return "null";
    }
  }

  Future<void> signUpWithEmail(
      String email, String password, String name, var context) async {
    print(_auth);

    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value != null) {
          await value.user!.sendEmailVerification();
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(uID)
              .set(({
                "email": email,
                "password": password,
                "uid": uID,
                "name": name,
              }))
              .then((_) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailVerification(),
                ));
          });
        }
      });
    }  on FirebaseAuthException catch (e) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message!),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
  }

  verifyEmail(c, user) {
    // print(user);
    user.reload();

    if (!user.emailVerified) {
      return false;
    } else {
      return true;
    }
  }
}
