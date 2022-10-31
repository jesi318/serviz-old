import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/models/user_model.dart';
import 'package:serviz/utils/colors.dart';

final useruid = FirebaseAuth.instance.currentUser!.uid;

class GetRegNo {
  final String documentID;
  var reg_num;
  var grp_id;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  GetRegNo({required this.documentID});

  // Future getcollection() async {
  //   await users
  //       .doc(useruid)
  //       .set(UserModel.fromMap());
  //   }

  getcollection() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .get()
        .then((event) {
      reg_num = event['reg_no'];
    });

    print(reg_num);
    return reg_num.toString();
  }

  getcollectiongrpno() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .get()
        .then((event) {
      grp_id = event['grp_id'];
    });

    print(grp_id);
    return grp_id.toString();
  }
}
