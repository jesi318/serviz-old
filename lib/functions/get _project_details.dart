import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/expansion_tile_card.dart';

class Get_project_details extends StatelessWidget {
  String projectID;
  Get_project_details({required this.projectID});

  @override
  Widget build(BuildContext context) {
    CollectionReference projects =
        FirebaseFirestore.instance.collection('projects');
    return FutureBuilder<DocumentSnapshot>(
        future: projects.doc(projectID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ExpansionTileCard(
              projectDescription: data['pDescription'],
              projectTitle: data['pTitle'],
            );
          } else {
            return ExpansionTileCard(
                projectTitle: 'Loading', projectDescription: 'Loading');
          }
        }));
  }
}
