import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:serviz/functions/get_week.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/drawer/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/widgets/progress_widget.dart';
import 'package:serviz/widgets/widget_card.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String week = "Week";
  List<String> wid = [];

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
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyHomeAppBar(),
        drawer: NavigationDrawer(),
        backgroundColor: AppColors.grey_background,
        body: Column(
          children: [
            Row(
              children: [ProgressWidget()],
            ),
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
            ))
          ],
        ));
  }
}
