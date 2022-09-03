import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              'Register Number',
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
        onTap: () {},
      ),
    ],
  );
}
