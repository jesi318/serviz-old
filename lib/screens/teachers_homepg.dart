import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/get_grplist.dart';
import 'package:serviz/functions/get_week.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/group_search_widget.dart';
import 'package:serviz/widgets/students_drawer/drawer.dart';

class TeachersHomePage extends StatefulWidget {
  const TeachersHomePage({super.key});

  @override
  State<TeachersHomePage> createState() => _TeachersHomePageState();
}

class _TeachersHomePageState extends State<TeachersHomePage> {
  List<String> gid = [];

  ScrollController? _controller;

  Future getGroupList() async {
    await FirebaseFirestore.instance.collection('group').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            print(element.reference);
            gid.add(element.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TeachersHomeAppBar(),
      drawer: NavigationDrawer(),
      backgroundColor: AppColors.grey_background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SearchWidget(),
          Expanded(
              child: FutureBuilder(
            future: getGroupList(),
            builder: (context, snapshot) {
              return ListView.builder(
                  // controller: _controller,
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: gid.length,
                  itemBuilder: (context, index) {
                    return GetGrpList(gid: gid[index]);
                  });
            },
          ))
        ],
      ),
    );
  }
}
