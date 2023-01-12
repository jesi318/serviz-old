import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/get_avl_grplist.dart';
import 'package:serviz/functions/get_regno.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/GrouplistCard.dart';
import 'package:serviz/widgets/appbar.dart';

import '../widgets/TeachersWidgetcard.dart';

class ViewGroups extends StatefulWidget {
  const ViewGroups({super.key});

  @override
  State<ViewGroups> createState() => _ViewGroupsState();
}

class _ViewGroupsState extends State<ViewGroups> {
  List selClass = [];
  List gid = ['null'];
  List gnullid = [];
  String? _selectedval = 'AIML';
  FocusNode DropFocusNode = new FocusNode();

  Future getWeekId() async {
    await FirebaseFirestore.instance
        .collection("meta")
        .doc("class")
        .get()
        .then((value) => selClass = List.from(value.data()!['names']));
  }

  Future getGroupList() async {
    await FirebaseFirestore.instance
        .collection("meta")
        .doc("groups-left")
        .get()
        .then((value) => gid = List.from(value.data()![_selectedval]));
  }

  Future getusernull() async {
    await FirebaseFirestore.instance
        .collection("meta")
        .doc("users-left")
        .get()
        .then((value) => gnullid = List.from(value.data()!['AIML']));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.grey_background,
        appBar: MyBackAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),

            //DropDown code
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: FutureBuilder(
                    future: getWeekId(),
                    builder: (context, snapshot) {
                      return DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          focusColor: AppColors.yellow_accent,
                          alignment: AlignmentDirectional.center,
                          style: GoogleFonts.poppins(
                            color: AppColors.white_text,
                            fontWeight: FontWeight.bold,
                          ),
                          dropdownColor: AppColors.black_background,
                          borderRadius: BorderRadius.circular(30),
                          value: _selectedval,
                          items: selClass
                              .map((item) => DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedval = val.toString();
                            });
                          });
                    }),
              ),
            ),

            //Tabbar Code
            Padding(
                padding: EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Container(
                      child: TabBar(
                          indicator: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.yellow_accent),
                              borderRadius: BorderRadius.circular(30)),
                          automaticIndicatorColorAdjustment: true,
                          splashBorderRadius: BorderRadius.circular(30),
                          tabs: [
                            Tab(
                              text: "Groups",
                            ),
                            Tab(text: "Not joined")
                          ]),
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.black_background,
                      ),
                    ),
                  ],
                )),

            Expanded(
              child: TabBarView(children: [
                // Tab 1 - groups
                gid != null
                    ? Center(
                        child: FutureBuilder(
                        future: getGroupList(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              // controller: _controller,
                              physics: BouncingScrollPhysics(),
                              itemCount: gid.length,
                              itemBuilder: (context, index) {
                                return GrouplistWidgetCard(
                                  grp: gid[index],
                                );
                              });
                        },
                      ))
                    : Container(),
                // Tab 2 - users
                Center(
                    child: FutureBuilder(
                  future: getusernull(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        // controller: _controller,
                        physics: BouncingScrollPhysics(),
                        itemCount: gnullid.length,
                        itemBuilder: (context, index) {
                          return GrouplistWidgetCard(grp: gnullid[index]);
                        });
                  },
                )),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
