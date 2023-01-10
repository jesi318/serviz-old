import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serviz/widgets/GrouplistCard.dart';
import 'package:serviz/widgets/TeachersWidgetcard.dart';
import 'package:serviz/widgets/widget_card.dart';

class GetGrpListAvl extends StatelessWidget {
  String gid;

  GetGrpListAvl({required this.gid});

  @override
  Widget build(BuildContext context) {
    CollectionReference group = FirebaseFirestore.instance.collection('group');
    return FutureBuilder<DocumentSnapshot>(
        future: group.doc(gid).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return GrouplistWidgetCard(
              grp: gid,
            );
          } else {
            return GrouplistWidgetCard(
              grp: 'Loading',
            );
          }
        }));
  }
}
