import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/drawer/drawer.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  // editing controller
  final groupNameEditingController = new TextEditingController();
  final classEditingController = new TextEditingController();
  // focus node
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    // group name field
    final groupNameField = TextFormField(
      focusNode: myFocusNode,
      cursorColor: AppColors.yellow_accent,
      autofocus: false,
      controller: groupNameEditingController,
      keyboardType: TextInputType.name,
      validator: ((value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Group name required");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid name (Min. 3 characters)");
        }
        return null;
      }),
      onSaved: (newValue) {
        groupNameEditingController.text = newValue!;
      },
      textInputAction: TextInputAction.next,
      style: GoogleFonts.poppins(
        color: AppColors.white_text,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.group,
          color: AppColors.yellow_accent,
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        labelText: 'Group Name',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white_text),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow_accent),
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: GoogleFonts.poppins(
          color: myFocusNode.hasFocus
              ? AppColors.yellow_accent
              : AppColors.white_text,
        ),
      ),
    );

    // group name field
    final classNameField = TextFormField(
      focusNode: myFocusNode,
      cursorColor: AppColors.yellow_accent,
      autofocus: false,
      controller: classEditingController,
      keyboardType: TextInputType.name,
      validator: ((value) {
        if (value!.isEmpty) {
          return ("Class required");
        }
        return null;
      }),
      onSaved: (newValue) {
        classEditingController.text = newValue!;
      },
      textInputAction: TextInputAction.next,
      style: GoogleFonts.poppins(
        color: AppColors.white_text,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.group,
          color: AppColors.yellow_accent,
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        labelText: 'Class',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white_text),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow_accent),
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: GoogleFonts.poppins(
          color: myFocusNode.hasFocus
              ? AppColors.yellow_accent
              : AppColors.white_text,
        ),
      ),
    );

    //signup button
    final createButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: AppColors.yellow_accent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (() {
          Get.toNamed('/home');
        }),
        child: Text(
          'Create',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: MyBackAppBar(),
      drawer: NavigationDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: AppColors.grey_background,
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    groupNameField,
                    SizedBox(height: 60),
                    classNameField,
                    SizedBox(height: 60),
                    createButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
