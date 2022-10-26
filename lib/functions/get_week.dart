import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serviz/widgets/widget_card.dart';

class GetWeek extends StatelessWidget {
  String weekid;

  GetWeek({required this.weekid});

  @override
  Widget build(BuildContext context) {
    CollectionReference week = FirebaseFirestore.instance
        .collection('group')
        .doc('g1')
        .collection('week');
    return FutureBuilder<DocumentSnapshot>(
        future: week.doc(weekid).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return WidgetCard(week: weekid, status: data['status']);
          } else {
            return WidgetCard(week: weekid, status: "Loading...");
          }
        }));
  }
}
