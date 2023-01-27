import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:serviz/functions/get_week.dart';
import 'package:serviz/screens/submissions_screen.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/students_drawer/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/widgets/progress_widget.dart';
import 'package:serviz/widgets/widget_card.dart';

import '../functions/get_regno.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String week = "Week";
  List<String> wid = [];
  String grp_num = "";
  String ideaExists = "false";
  String status = "";
  bool isLoading = false;

  ScrollController? _controller;

  Future getWeekId() async {
    await FirebaseFirestore.instance
        .collection('group')
        .doc('g1')
        .collection('week')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((element) {
            print(element.reference);
            wid.add(element.reference.id);
          }),
        );

    return wid;
  }

  getIdeaExists() async {
    grp_num = await GetRegNo(documentID: useruid).getcollectiongrpno();

    ideaExists = await FirebaseFirestore.instance
        .collection("meta")
        .doc("project-ideas")
        .get()
        .then((value) {
      if (value.get(grp_num) != null) {
        ideaExists = "true";
      } else {
        ideaExists = "false";
      }

      return ideaExists;
    });

    await FirebaseFirestore.instance
        .collection('meta')
        .doc('project-ideas')
        .get()
        .then((DocumentSnapshot snapshot) {
      var statustemp = snapshot.get(grp_num);

      Map mapEventData = statustemp;
      status = mapEventData['status'];
    });
  }

  @override
  void initState() {
    // _controller = ScrollController();

    // SchedulerBinding.instance.addPostFrameCallback(
    //   (_) {
    //     _controller?.jumpTo(
    //       _controller!.position.maxScrollExtent,
    //     );
    //   },
    // );]
    getIdeaExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyHomeAppBar(),
        drawer: NavigationDrawer(),
        backgroundColor: AppColors.grey_background,
        body: Column(
          children: [
            FutureBuilder(
                future: getIdeaExists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Row(
                      children: [
                        (ideaExists == "true" && status == "pending") ||
                                ideaExists == "false"
                            ? InkWell(
                                onTap: () {
                                  Get.to(SubmissionsScreen(
                                    grp_num: grp_num,
                                    ideaExists: ideaExists,
                                    status: status,
                                  ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20.0),
                                  child: Card(
                                    color: AppColors.yellow_accent,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (1 / 5),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow_accent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Submit your Idea',
                                            style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.add_task_rounded,
                                            size: 60,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : ideaExists == "true" && status == "approved"
                                ? ProgressWidget()
                                : ideaExists == "true" && status == "rejected"
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(SubmissionsScreen(
                                            grp_num: grp_num,
                                            ideaExists: ideaExists,
                                            status: status,
                                          ));
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 20.0),
                                          child: Card(
                                            color: AppColors.yellow_accent,
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  (1 / 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.yellow_accent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Submit your Idea',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.add_task_rounded,
                                                    size: 60,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Expanded(
                child: FutureBuilder(
              future: getWeekId(),
              builder: (context, snapshot) {
                return ListView.builder(
                    // controller: _controller,
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: wid.length,
                    itemBuilder: (context, index) {
                      return GetWeek(weekid: wid[index]);
                    });
              },
            )),
          ],
        ));
  }
}
