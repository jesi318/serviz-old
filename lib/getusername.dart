import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';

final useruid = FirebaseAuth.instance.currentUser!.uid;

class GetUserName extends StatelessWidget {
  final String documentID;

  GetUserName({required this.documentID});

  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                Text(
                  "${data['name']}",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.yellow_accent),
                ),
                Text(
                  "${data['reg_no']}",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.yellow_accent),
                )
              ],
            );
          }

          return Text("loading..");
        }));
  }
}
