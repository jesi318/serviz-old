import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/auth_controller.dart';
import 'package:serviz/utils/colors.dart';

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
            Text(
              'Name',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.yellow_accent),
            ),
            Text(
              'Register No',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.yellow_accent),
            ),
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
        onTap: () {},
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
          Icons.settings,
          color: AppColors.yellow_accent,
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, color: AppColors.yellow_accent),
        ),
        onTap: () {},
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
