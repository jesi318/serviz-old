import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:serviz/screens/create_join_group.dart';
import 'package:serviz/screens/homepg.dart';
import 'package:serviz/screens/login.dart';
import 'package:serviz/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serviz/models/user_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //user will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => CreateJoinGroupScreen());
    }
  }

  void register(String email, String password, String reg_no, String classname,
      String name) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(reg_no, classname, name)});
    } catch (e) {
      Get.snackbar(
        "About User",
        "user Message",
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account Creation Failed",
          style: TextStyle(color: AppColors.white_text),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: AppColors.white_text),
        ),
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About login",
        "Login Message",
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login Failed",
          style: TextStyle(color: AppColors.white_text),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: AppColors.white_text),
        ),
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }

  postDetailsToFirestore(String reg_no, String classname, String name) async {
    // calling our firestore
    // calling our model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the valus
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = name;
    userModel.reg_no = reg_no;
    userModel.classname = classname;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Get.snackbar('User info', 'Info stored');
  }
}
