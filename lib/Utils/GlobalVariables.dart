import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static String userEmail = "";
  static String userName = "";
  static String userUID = "";
}

class DataService {
  late String initUserEmailId = "";
  late String initUsername = "";
  late String initUserImage = "";

  String get getInitUserName => initUsername;
  String get getInitUserEmail => initUserEmailId;
  String get getInitUserImage => initUserImage;

  String get uID {
    try {
      final uid = (FirebaseAuth.instance.currentUser)!.uid;

      return uid;
    } catch (e) {
      return "null";
    }
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uID)
        .get()
        .then((doc) {
      GlobalVariables.userEmail = doc.data()!["email"];
      GlobalVariables.userName = doc.data()!["name"];

      GlobalVariables.userUID = uID;
      print("Username" + GlobalVariables.userName);
      print("UserEmail" + GlobalVariables.userEmail);
    });
  }
}
