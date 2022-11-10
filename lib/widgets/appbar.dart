import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';

// AppBar base
PreferredSizeWidget MyAppBar() {
  return AppBar(
    toolbarHeight: 90,
    backgroundColor: AppColors.yellow_accent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      'Serviz',
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 40),
    ),
    foregroundColor: Colors.black,
  );
}

// AppBar with dashborad
PreferredSizeWidget MyHomeAppBar() {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
          color: AppColors.black_background,
        ),
      )
    ],
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(Icons.dashboard),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }),
    toolbarHeight: 90,
    backgroundColor: AppColors.yellow_accent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      'Serviz',
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
    ),
    foregroundColor: Colors.black,
  );
}

// AppBar with back button
PreferredSizeWidget MyBackAppBar() {
  return AppBar(
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.black_background,
        ),
        onPressed: () {
          Get.back();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }),
    toolbarHeight: 90,
    backgroundColor: AppColors.yellow_accent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      'Serviz',
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
    ),
    foregroundColor: Colors.black,
  );
}

PreferredSizeWidget TeachershomeAppBar() {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {
            Get.toNamed('/teachersnotifscreen');
          },
          icon: Icon(Icons.notifications),
          color: AppColors.black_background,
        ),
      )
    ],
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(Icons.dashboard),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }),
    toolbarHeight: 90,
    backgroundColor: AppColors.yellow_accent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      'Serviz',
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
    ),
    foregroundColor: Colors.black,
  );
}

// AppBar with back button
PreferredSizeWidget TeachersHomeAppBar() {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {
            Get.toNamed('/teachersnotifscreen');
          },
          icon: Icon(Icons.message_rounded),
          color: AppColors.black_background,
        ),
      )
    ],
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(
          Icons.dashboard,
          color: AppColors.black_background,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }),
    toolbarHeight: 90,
    backgroundColor: AppColors.yellow_accent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      'Serviz',
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
    ),
    foregroundColor: Colors.black,
  );
}
