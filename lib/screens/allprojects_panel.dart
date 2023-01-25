import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  List<Map<String, dynamic>> allProjects = [];
  List<Map<String, dynamic>> foundProjects = [
    {'start': 'yeah'}
  ];

  @override
  initState() {
    super.initState();
  }

  Future getDocs() async {
    if (allProjects.isEmpty) {
      foundProjects = [];
      await FirebaseFirestore.instance
          .collection('projects')
          .get()
          .then((snapshot) => snapshot.docs.forEach((element) {
                allProjects.add(element.data());
              }));
      foundProjects = allProjects;
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allProjects;
    } else {
      results = allProjects
          .where((project) => project['title']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      print(results);
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundProjects = results;
    });
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
      onChanged: (value) {
        _runFilter(value);
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
            child: foundProjects.isNotEmpty
                ? FutureBuilder(
                    future: getDocs(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: foundProjects.length,
                          itemBuilder: (context, index) {
                            return ExpansionTileCard(
                              projectTitle: foundProjects[index]['title'],
                              projectDescription: foundProjects[index]['desc'],
                            );
                          });
                    },
                  )
                : const Text(
                    'No projects found',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.white_text,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
