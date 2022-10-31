import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/get_regno.dart';
import 'package:serviz/functions/getusername.dart';
import 'package:serviz/models/group_model.dart';
import 'package:serviz/models/user_model_gid.dart';
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
  final useruid = FirebaseAuth.instance.currentUser!.uid;
  final groupNameEditingController = new TextEditingController();
  final classEditingController = new TextEditingController();
  // focus node
  FocusNode grpmyFocusNode = new FocusNode();
  FocusNode classmyFocusNode = new FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  //FocusNode myFocusNode = new FocusNode();
  late Rx<User?> _user;

  String grp_id = "";
  String faculty_name = "Shamanth";
  String username = "";
  s() async {
    var sv = await GetRegNo(documentID: useruid).getcollection();
    print(sv);
    grp_id = 'G' + sv;
    print(grp_id);

    return grp_id;
  }

  get_username_inList() async {
    var temp = await GetRegNo(documentID: useruid).getcollectionusername();

    print(temp);

    username = temp;
    List memberlist = [username];

    print(memberlist);
    return memberlist;
  }

  @override
  void initState() {
    s();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // group name field
    final groupNameField = TextFormField(
      focusNode: grpmyFocusNode,
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
          color: grpmyFocusNode.hasFocus
              ? AppColors.yellow_accent
              : AppColors.white_text,
        ),
      ),
    );

    // // class name field
    // final classNameField = TextFormField(
    //   focusNode: classmyFocusNode,
    //   cursorColor: AppColors.yellow_accent,
    //   autofocus: false,
    //   controller: classEditingController,
    //   keyboardType: TextInputType.name,
    //   validator: ((value) {
    //     if (value!.isEmpty) {
    //       return ("Class required");
    //     }
    //     return null;
    //   }),
    //   onSaved: (newValue) {
    //     classEditingController.text = newValue!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   style: GoogleFonts.poppins(
    //     color: AppColors.white_text,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(
    //       Icons.class_rounded,
    //       color: AppColors.yellow_accent,
    //     ),
    //     contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
    //     labelText: 'Class',
    //     enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: AppColors.white_text),
    //         borderRadius: BorderRadius.circular(20)),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: AppColors.yellow_accent),
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     labelStyle: GoogleFonts.poppins(
    //       color: classmyFocusNode.hasFocus
    //           ? AppColors.yellow_accent
    //           : AppColors.white_text,
    //     ),
    //   ),
    // );

    //signup button
    final createButton = Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: () {
        postGroupIDtoUserProfile(grp_id);

        postGroupDetailsToGroup(faculty_name);
        Get.toNamed('/home');
        //What to do on pressed
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1 / 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.yellow_accent),
        child: Center(
          child: Text(
            "Create",
            style: GoogleFonts.poppins(
                color: AppColors.black_background,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: MyBackAppBar(),
      drawer: NavigationDrawer(),
      backgroundColor: AppColors.grey_background,
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 150),
                    groupNameField,
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

  postGroupIDtoUserProfile(String grp_id) async {
    // calling our firestore
    // calling our model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModelGid userModelGid = UserModelGid();

    // writing all the valus
    userModelGid.grp_id = grp_id;

    await firebaseFirestore
        .collection("users")
        .doc(useruid)
        .update(userModelGid.toMap());
    Get.snackbar('Group info', 'Info stored');
  }

  postGroupDetailsToGroup(String faculty_name) async {
    // calling our firestore
    // calling our model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    GroupModel grpModel = GroupModel();

    // writing all the valus
    grpModel.faculty_name = faculty_name;

    await firebaseFirestore
        .collection("group")
        .doc(grp_id)
        .set(grpModel.toMap());
    Get.snackbar('Group info', 'Info stored to group collection');

    await firebaseFirestore.collection("group").doc(grp_id).update(
        {"members": FieldValue.arrayUnion(await get_username_inList())});
    Get.snackbar('Group info', 'Info stored to group collection');
  }
}
