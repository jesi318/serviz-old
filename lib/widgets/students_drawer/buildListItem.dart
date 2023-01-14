import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/auth_controller.dart';
import 'package:serviz/functions/getusername.dart';
import 'package:serviz/screens/requestScreen.dart';
import 'package:serviz/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final useruid = FirebaseAuth.instance.currentUser!.uid;
String myDocID = useruid;
late DocumentSnapshot documentSnapshot;

Widget buildListItems(BuildContext context) {
  return Column(
    children: [
      DrawerHeader(
          child: Column(
        children: [
          Icon(
            Icons.dashboard_customize_rounded,
            color: AppColors.yellow_accent,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Dashboard',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: AppColors.yellow_accent),
          ),
        ],
      )),
      ListTile(
        /* shape: Border(
          top: BorderSide(color: AppColors.yellow_accent, width: 1),
          bottom: BorderSide(color: AppColors.yellow_accent, width: 1),
        ),*/
        leading: Icon(
          Icons.face_rounded,
          color: AppColors.yellow_accent,
          size: 40,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(builder: ((context, snapshot) {
              return GetUserName(documentID: useruid);
            })),
            SizedBox(
              height: 56,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.yellow_accent),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 60,
      ),
      Divider(
        height: 20,
        thickness: 2,
      ),
      ListTile(
        leading: Icon(
          Icons.lightbulb,
          color: AppColors.yellow_accent,
        ),
        title: Text(
          'View past Ideas',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, color: AppColors.yellow_accent),
        ),
        onTap: () {
          Get.toNamed('/allprojectspage');
        },
      ),
      SizedBox(
        height: 30,
      ),
      ListTile(
        leading: Icon(
          Icons.group_work_rounded,
          color: AppColors.yellow_accent,
        ),
        title: Text(
          'My Group',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, color: AppColors.yellow_accent),
        ),
        onTap: () {
          Get.toNamed('/mygroupform');
        },
      ),
      SizedBox(
        height: 30,
      ),
      ListTile(
        leading: const Icon(
          Icons.hdr_weak_rounded,
          color: AppColors.yellow_accent,
        ),
        title: Text(
          'Requests',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, color: AppColors.yellow_accent),
        ),
        onTap: () {
          Get.toNamed('submitrequestspage');
        },
      ),
      SizedBox(
        height: 30,
      ),
      ListTile(
        leading: const Icon(
          Icons.logout_rounded,
          color: AppColors.red_text,
        ),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, color: AppColors.red_text),
        ),
        onTap: () {
          AuthController.instance.logOut();
        },
      ),
    ],
  );
}

Future<DocumentSnapshot> getudata() async {
  String myDocID = useruid;
  late DocumentSnapshot documentSnapshot;

  await FirebaseFirestore.instance
      .collection("users")
      .doc(useruid)
      .get()
      .then((value) => documentSnapshot = value);

  return documentSnapshot;
}
