import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/getusername.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _titletextController = TextEditingController();
  final _descriptiontextController = TextEditingController();
  FocusNode mytitleFocusNode = new FocusNode();
  FocusNode mydescFocusNode = new FocusNode();
  String username = "";
  String grp_id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBackAppBar(),
      backgroundColor: AppColors.grey_background,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Titletext(),
                SizedBox(
                  height: 20,
                ),
                Descriptiontext(),
                SizedBox(
                  height: 25,
                ),
                Bounce(
                  duration: Duration(milliseconds: 110),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("request")
                        .doc("notification")
                        .update({
                      'AIML': FieldValue.arrayUnion([
                        {
                          'title': _titletextController.text,
                          'description': _descriptiontextController.text,
                          'status': 'pending'
                        }
                      ])
                    });
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 1 / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.yellow_accent),
                      child: Center(
                        child: Bounce(
                          duration: Duration(milliseconds: 110),
                          onPressed: () {
                            //do the auth control here
                          },
                          child: Text(
                            'Send Request',
                            style: GoogleFonts.poppins(
                                color: AppColors.black_background,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Titletext() => TextField(
        focusNode: mytitleFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _titletextController,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          color: AppColors.white_text,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white_text),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellow_accent),
              borderRadius: BorderRadius.circular(20)),
          labelText: 'Request Title',
          labelStyle: GoogleFonts.poppins(
            color: mytitleFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          suffixIcon: _titletextController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: AppColors.yellow_accent,
                  ),
                  onPressed: () {
                    _titletextController.clear();
                  },
                ),
        ),
      );

  Widget Descriptiontext() => TextField(
        maxLines: 10,
        focusNode: mydescFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _descriptiontextController,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          color: AppColors.white_text,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white_text),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellow_accent),
              borderRadius: BorderRadius.circular(20)),
          labelText: 'Request Description',
          labelStyle: GoogleFonts.poppins(
            color: mydescFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          suffixIcon: _descriptiontextController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: AppColors.yellow_accent,
                  ),
                  onPressed: () {
                    _descriptiontextController.clear();
                  },
                ),
        ),
      );
}
