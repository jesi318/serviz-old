import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';

PreferredSizeWidget MyAppBar() {
  return AppBar(
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
