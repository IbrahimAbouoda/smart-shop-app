import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../views/General/login/models/user.dart';

class FbAuthentication {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  void getCurrentUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String email = user.email ?? ""; // User's email
      String uid = user.uid; // User's UID

      print("Email: $email");
      print("UID: $uid");
    } else {
      print("No user is currently signed in.");
    }
  }

  void getUserNameFromFirestore(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(uid).get();
    if (userSnapshot.exists) {
      String name = userSnapshot.get(
          'name'); // Assuming you have a 'name' field in your user document
      print("User's Name: $name");
    } else {
      print("User document does not exist.");
    }
  }

  static dynamic loginWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static dynamic signUpWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /////////////////////

  static logoutUser() {
    _auth.signOut();
  }

  /////////////////

  static Future<UserModel?> getUserData(
      BuildContext context, String email) async {
    UserModel? userModel;
    try {
      DocumentSnapshot snapshot =
          await _db.collection('Users').doc(email).get();

      if (snapshot.get("role").toString().isNotEmpty) {
        userModel = UserModel.fromFirebase(
            snapshot as DocumentSnapshot<Map<String, dynamic>>);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
      log(e.toString());
    }
    return userModel;
  }

  //////////////////////

  static Future<bool> addNewUser(BuildContext context, UserModel user) async {
    try {
      await _db.collection("Users").doc(user.email).set(user.toFirebase());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logged in by: ${user.email}')));
      return true;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
      return false;
    }
  }

  ///////////////

  static Future<void> updateUserToken(
      BuildContext context, String email, String newToken) async {
    try {
      await _db.collection("Users").doc(email).update({"token": newToken});
    } catch (error) {
      var snackBar = const SnackBar(
          content: Text('Error update token, please logout and login again'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //////////////////////////
}
