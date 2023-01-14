import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/expansion_tile_card.dart';

class AllProjectsPanel extends StatefulWidget {
  const AllProjectsPanel({super.key});

  @override
  State<AllProjectsPanel> createState() => _AllProjectsPanelState();
}

class _AllProjectsPanelState extends State<AllProjectsPanel> {
  List<String> projectID = ['null'];

  recvFunc() async {
    await FirebaseFirestore.instance.collection('projects');
  }

  Future getDocs() async {
    await FirebaseFirestore.instance
        .collection('projects')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              projectID = [];
              projectID.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_background,
      appBar: MyBackAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: getDocs(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ExpansionTileCard(
                        projectTitle: projectID[index],
                        projectDescription:
                            'ooooooooo yeaaaaaaaaaahhhhhhhhhhhhhhhhhh',
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
