import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/get_regno.dart';
import 'package:serviz/functions/getusername.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class MyGroupForm extends StatefulWidget {
  const MyGroupForm({super.key});

  @override
  State<MyGroupForm> createState() => _MyGroupFormState();
}

class _MyGroupFormState extends State<MyGroupForm> {
  final useruid = FirebaseAuth.instance.currentUser!.uid;
  String username = '';
  String grp_num = '';
  String faculty_name = '';
  List members = [];
  List requests = [];
  int action = 0;
  //Map requests = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_background,
      appBar: MyBackAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: FutureBuilder(
                    future: getMyGroupNum(),
                    builder: (context, snapshot) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 1 / 7,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            color: AppColors.black_background,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.groups_rounded,
                              color: AppColors.white_text,
                              size: 55,
                            ),
                            Text(grp_num,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: AppColors.yellow_accent)),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1 / 2,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: AppColors.black_background,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FutureBuilder(
                      future: getMyGroupDetails(),
                      builder: (context, snapshot) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text("Faculty in Charge",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: AppColors.yellow_accent)),
                                    SizedBox(height: 10),
                                    Text(faculty_name,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: AppColors.white_text)),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Team Members',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: AppColors.yellow_accent),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: members.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        members[index],
                                        style: GoogleFonts.poppins(
                                            color: AppColors.white_text),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Bounce(
            duration: Duration(milliseconds: 110),
            onPressed: () {
              //What to do on pressed
              exitGroup();
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height * 1 / 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.black_background,
                  border: Border.all(color: AppColors.red_text, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.exit_to_app_rounded,
                    color: AppColors.red_text,
                  ),
                  Text(
                    'Exit Group',
                    style: GoogleFonts.poppins(
                        color: AppColors.red_text,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getMyGroupNum() async {
    grp_num = await GetRegNo(documentID: useruid).getcollectiongrpno();
  }

  getMyGroupDetails() async {
    //grp_num = await GetRegNo(documentID: useruid).getcollectiongrpno();
    username = await GetRegNo(documentID: useruid).getcollectionusername();

    await FirebaseFirestore.instance
        .collection('group')
        .doc(grp_num)
        .get()
        .then((data) => {
              faculty_name = data['faculty_name'],
              members = data['members'],
            });

    checkRequest();
  }

  checkRequest() async {
    // requests
    await FirebaseFirestore.instance
        .collection('group')
        .doc(grp_num)
        .get()
        .then((data) => {
              //request = data['requests'],
              requests = data['requests'],
              if (requests.isNotEmpty)
                {
                  print(requests),
                  showRequest(context),
                }
            });
  }

  exitGroup() async {
    try {
      //grp_num = await GetRegNo(documentID: useruid).getcollectiongrpno();

      await FirebaseFirestore.instance.collection('group').doc(grp_num).update({
        'members': FieldValue.arrayRemove([username])
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(useruid)
          .update({'grp_id': 'null'});

      // add user to meta/users-left
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(useruid).get();
      Map<String, dynamic>? data = docSnapshot.data();
      String classname = data?['classname'];
      await FirebaseFirestore.instance
          .collection("meta")
          .doc("users-left")
          .update({
        classname: FieldValue.arrayUnion([username])
      });

      Get.snackbar("Successfull", "Exited group");
      Get.offAllNamed('/createjoingroup');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Request pop up
  Future showRequest(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                title: Text("Join request"),
                titleTextStyle: GoogleFonts.poppins(
                    color: AppColors.yellow_accent, fontSize: 30),
                backgroundColor: AppColors.black_background,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Done'),
                  )
                ],
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: AppColors.black_background,
                  child: ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        String key = requests[index].keys.elementAt(0);
                        return ListTile(
                          title: Text(
                            key,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    requestAccept(key, index).then(
                                      (value) => setState(() => requests),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    requestReject(key, index).then(
                                      (value) => setState(() => requests),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
              );
            }),
          );
        });
  }

  Future requestAccept(user, index) async {
    print("Accepted");
    try {
      // update accepted user's grp_id
      await FirebaseFirestore.instance
          .collection('users')
          .doc(requests[index][user])
          .update({'grp_id': grp_num});
      // add in group members
      await FirebaseFirestore.instance.collection("group").doc(grp_num).update({
        "members": FieldValue.arrayUnion([user])
      });
      // remove from request list
      await FirebaseFirestore.instance.collection('group').doc(grp_num).update({
        'requests': FieldValue.arrayRemove([
          {user: requests[index][user]}
        ])
      }).then((value) {
        Get.snackbar('Successfull', 'Added member');
        requests.removeAt(index);
        print(requests);
      });
      //remove from users-left
    } catch (e) {
      Get.snackbar('Error', 'Action failed');
    }
  }

  Future requestReject(user, index) async {
    print("Rejected");
    try {
      await FirebaseFirestore.instance.collection('group').doc(grp_num).update({
        'requests': FieldValue.arrayRemove([
          {user: requests[index][user]}
        ])
      }).then((value) {
        Get.snackbar('Successfull', 'Request rejected');
        requests.removeAt(index);
      });
    } catch (e) {
      Get.snackbar('Error', 'Action failed');
    }
  }
}

// option 2 if error
// ListTile(
//             title: const Text('The Title'),
//             subtitle: const Text('The Subtitle'),
//             trailing: SizedBox(
//               width: 150,
//               child: Row(
//                 children: [
//                   IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
//                   IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
//                   IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
//                 ],
//               ),
//             ),
//           )