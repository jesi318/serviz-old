import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/widgets/progress_widget.dart';
import 'package:serviz/widgets/upload_doc.dart';

import '../functions/get_regno.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class DocSubmissionscreen extends StatefulWidget {
  const DocSubmissionscreen({super.key});

  @override
  State<DocSubmissionscreen> createState() => _DocSubmissionscreenState();
}

class _DocSubmissionscreenState extends State<DocSubmissionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBackAppBar(),
      backgroundColor: AppColors.black_background,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Submit documents',
            style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.yellow_accent),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
                height: 100.0, child: Image.asset("assets/icons/folder.png")),
          ),
          SizedBox(
            height: 20,
          ),
          const ExpansionTile(
            collapsedIconColor: AppColors.white_text,
            collapsedTextColor: AppColors.white_text,
            textColor: AppColors.yellow_accent,
            iconColor: AppColors.yellow_accent,
            title: Text('Community Letter'),
            children: <Widget>[UploadDocWidget()],
          ),
          const ExpansionTile(
            collapsedIconColor: AppColors.white_text,
            collapsedTextColor: AppColors.white_text,
            textColor: AppColors.yellow_accent,
            iconColor: AppColors.yellow_accent,
            title: Text('Flow Diagram'),
            children: <Widget>[UploadDocWidget()],
          ),
          const ExpansionTile(
            collapsedIconColor: AppColors.white_text,
            collapsedTextColor: AppColors.white_text,
            textColor: AppColors.yellow_accent,
            iconColor: AppColors.yellow_accent,
            title: Text('Work Flow'),
            children: <Widget>[UploadDocWidget()],
          ),
          const ExpansionTile(
            collapsedIconColor: AppColors.white_text,
            collapsedTextColor: AppColors.white_text,
            textColor: AppColors.yellow_accent,
            iconColor: AppColors.yellow_accent,
            title: Text('Budget Plan'),
            children: <Widget>[UploadDocWidget()],
          ),
        ],
      )),
    );
  }
}
