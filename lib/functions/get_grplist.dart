import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serviz/widgets/TeachersWidgetcard.dart';
import 'package:serviz/widgets/widget_card.dart';

class GetGrpList extends StatelessWidget {
  String gid;

  GetGrpList({required this.gid});

  @override
  Widget build(BuildContext context) {
    CollectionReference group = FirebaseFirestore.instance.collection('group');
    return FutureBuilder<DocumentSnapshot>(
        future: group.doc(gid).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return TeachersWidgetCard(week: gid, status: 'status');
          } else {
            return TeachersWidgetCard(week: gid, status: "Loading...");
          }
        }));
  }
}
