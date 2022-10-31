import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/get_regno.dart';
import 'package:serviz/models/user_model_gid.dart';
import 'package:serviz/utils/colors.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/drawer/buildListItem.dart';

final useruid = FirebaseAuth.instance.currentUser!.uid;

class JoinGroupForm extends StatefulWidget {
  @override
  State<JoinGroupForm> createState() => _JoinGroupFormState();
}

class _JoinGroupFormState extends State<JoinGroupForm> {
  final _textController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  String username = "";
  String grp_id = "";

  get_username_inList() async {
    var temp1 = await GetRegNo(documentID: useruid).getcollectionusername();

    print(temp1);

    username = temp1;
    List memberlist = [username];

    print(memberlist);
    return memberlist;
  }

  get_grp_id() async {
    var temp = await GetRegNo(documentID: useruid).getcollectiongrpno();

    grp_id = temp;

    return grp_id;
  }

  @override
  void initState() {
    super.initState();
    get_grp_id();

    _textController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBackAppBar(),
      backgroundColor: AppColors.grey_background,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              groupcodetext(),
              SizedBox(
                height: 30,
              ),
              Bounce(
                duration: Duration(milliseconds: 110),
                onPressed: () {
                  AssignGroupIDtoprofile(_textController.text);
                  print("#######");
                  print(grp_id);
                  print(username);
                  JoinGroupwithGID(grp_id);
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
                      'Join',
                      style: GoogleFonts.poppins(
                          color: AppColors.black_background,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget groupcodetext() => TextField(
        focusNode: myFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _textController,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          color: AppColors.white_text,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white_text),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellow_accent),
              borderRadius: BorderRadius.circular(20)),
          labelText: 'Group Code',
          labelStyle: GoogleFonts.poppins(
            color: myFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          suffixIcon: _textController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: AppColors.yellow_accent,
                  ),
                  onPressed: () {
                    _textController.clear();
                  },
                ),
        ),
      );

  AssignGroupIDtoprofile(String grp_id) async {
    // calling our firestore
    // calling our model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModelGid userModelGid = UserModelGid();

    // writing all the valus
    userModelGid.grp_id = grp_id;

    await firebaseFirestore
        .collection("users")
        .doc(useruid)
        .update(userModelGid.toMap());
    Get.snackbar('Assigned Group', 'Info stored');
  }

  JoinGroupwithGID(String grp_id) async {
    // calling our firestore
    // calling our model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    await firebaseFirestore.collection("group").doc(grp_id).update(
        {"members": FieldValue.arrayUnion(await get_username_inList())});
    Get.snackbar('Group info', 'NAme stored to group collection');
  }
}
