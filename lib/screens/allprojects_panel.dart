import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serviz/functions/get%20_project_details.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/expansion_tile_card.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProjectsPanel extends StatefulWidget {
  const AllProjectsPanel({super.key});

  @override
  State<AllProjectsPanel> createState() => _AllProjectsPanelState();
}

class _AllProjectsPanelState extends State<AllProjectsPanel> {
  // controller
  final searchEditingController = new TextEditingController();
  // focus node
  FocusNode searchFocusNode = new FocusNode();

  List<String> projectID = ['null'];

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
    CollectionReference projects =
        FirebaseFirestore.instance.collection('projects');

    // Search field
    final searchField = TextFormField(
      focusNode: searchFocusNode,
      cursorColor: AppColors.yellow_accent,
      autofocus: false,
      controller: searchEditingController,
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        searchEditingController.text = newValue!;
      },
      textInputAction: TextInputAction.done,
      style: GoogleFonts.poppins(
        color: AppColors.white_text,
        fontWeight: FontWeight.bold,
      ),
      onTap: () {
        print('Search');
        print(searchEditingController.text);
      },
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search_outlined,
          color: AppColors.yellow_accent,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: 'Search',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white_text),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow_accent),
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: GoogleFonts.poppins(
          color: searchFocusNode.hasFocus
              ? AppColors.yellow_accent
              : AppColors.white_text,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.grey_background,
      appBar: MyBackAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          searchField,
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: FutureBuilder(
            future: getDocs(),
            builder: (context, snapshot) {
              return ListView.builder(
                  // controller: _controller,
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: projectID.length,
                  itemBuilder: (context, index) {
                    return Get_project_details(projectID: projectID[index]);
                  });
            },
          )),
        ],
      ),
    );
  }
}
