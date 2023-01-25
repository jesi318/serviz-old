import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/widgets/appbar.dart';

import '../functions/get_regno.dart';
import '../utils/colors.dart';

class SubmissionsScreen extends StatefulWidget {
  const SubmissionsScreen({super.key});

  @override
  State<SubmissionsScreen> createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends State<SubmissionsScreen> {
  final _titletextController = TextEditingController();
  final _descriptiontextController = TextEditingController();

  FocusNode mytitleFocusNode = new FocusNode();
  FocusNode mydescFocusNode = new FocusNode();
  String grp_num = "";
  String ideaExists = "";
  String status = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyGroupNum();
  }

  getIdeaExists() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("meta")
        .doc("project-ideas")
        .get();

    try {
      if (snapshot.get('idea_$grp_num') != null) ideaExists = "true";
    } catch (e) {
      ideaExists = "false";
    }
  }

  getIdeaStatus() async {
    await FirebaseFirestore.instance
        .collection('meta')
        .doc('project-ideas')
        .get()
        .then((DocumentSnapshot snapshot) {
      var statustemp = snapshot.get('idea_$grp_num');

      Map mapEventData = statustemp;
      status = mapEventData['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black_background,
      appBar: MyBackAppBar(),
      body: Container(
        child: Stack(children: [
          SingleChildScrollView(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                  future: getIdeaExists(),
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ideaExists == "false"
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Submit Your Idea",
                                      style: GoogleFonts.poppins(
                                          color: AppColors.yellow_accent,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                      FirebaseFirestore.instance
                                          .collection('meta')
                                          .doc('project-ideas')
                                          .update({
                                        'idea_$grp_num': {
                                          'pTitle': _titletextController.text,
                                          'pDescription':
                                              _descriptiontextController.text,
                                          'grp_id': grp_num,
                                          'status': 'pending'
                                        }
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: AppColors.yellow_accent),
                                        child: Center(
                                          child: Bounce(
                                            duration:
                                                Duration(milliseconds: 110),
                                            onPressed: () {
                                              //do the auth control here
                                            },
                                            child: Text(
                                              'Post Idea',
                                              style: GoogleFonts.poppins(
                                                  color: AppColors
                                                      .black_background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : FutureBuilder(
                                future: getIdeaStatus(),
                                builder: (context, snapshot) {
                                  return Column(
                                    children: [
                                      Text(
                                          "Your Idea has already been Submitted for Approval. Hang Tight!",
                                          style: GoogleFonts.poppins(
                                              color: AppColors.yellow_accent,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      ClipRRect(
                                        child: Container(
                                            height: 100.0,
                                            child: Image.asset(
                                                "assets/icons/done.png")),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text("Status : $status",
                                          style: GoogleFonts.poppins(
                                              color: AppColors.white_text,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  );
                                })
                      ],
                    );
                  }),
            ),
          ))
        ]),
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
          labelText: 'Project Title',
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
          labelText: 'Project Description',
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

  getMyGroupNum() async {
    grp_num = await GetRegNo(documentID: useruid).getcollectiongrpno();
  }
}
