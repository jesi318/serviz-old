import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/get_regno.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadWeekForm extends StatefulWidget {
  UploadWeekForm({Key? key}) : super(key: key);

  @override
  State<UploadWeekForm> createState() => _UploadWeekFormState();
}

class _UploadWeekFormState extends State<UploadWeekForm> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  bool? uploaded;
  String ss = "";
  s() async {
    var sv = await GetRegNo(documentID: useruid).getcollectiongrpno();
    ss = sv;
  }

  Future uploadFile() async {
    final path = 'files/${ss}/${Get.arguments}/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final Storageref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      s();
      uploadTask = Storageref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download Link: $urlDownload');

    setState(() {
      uploaded = true;
      uploadTask = null;
    });

    if (uploaded == true) {
      Get.snackbar('Uploaded', 'Pdf file has been uploaded',
          snackPosition: SnackPosition.BOTTOM, colorText: AppColors.white_text);
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) {
      return;
    }

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyBackAppBar(),
        backgroundColor: AppColors.black_background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 19,
            ),
            Row(
              children: [
                Expanded(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 1 / 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      Get.arguments,
                      style: GoogleFonts.poppins(
                          color: AppColors.white_text, fontSize: 27),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                pickedFile != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 70),
                          ClipRRect(
                            child: Image.asset("assets/icons/Pdf_icon.png"),
                          ),
                          SizedBox(height: 30),
                          Text(
                            pickedFile!.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 30),
                        ],
                      )
                    : Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                                child: dottedBorder(context),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width - 80,
                                decoration: BoxDecoration(
                                    color: AppColors.black_background,
                                    borderRadius: BorderRadius.circular(12)))),
                      )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: Bounce(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: MediaQuery.of(context).size.height * 1 / 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.yellow_accent),
                          child: Center(
                            child: Text(
                              'Upload',
                              style: GoogleFonts.poppins(
                                  color: AppColors.black_background,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 110),
                        onPressed: uploadFile),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: Bounce(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: MediaQuery.of(context).size.height * 1 / 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.red_text),
                          child: Center(
                            child: Text(
                              'Clear',
                              style: GoogleFonts.poppins(
                                  color: AppColors.black_background,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 110),
                        onPressed: () {
                          setState(() {
                            pickedFile = null;
                          });
                        }),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget dottedBorder(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: AppColors.yellow_accent,
          radius: Radius.circular(12),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_copy_outlined,
                    color: AppColors.yellow_accent,
                    size: 50,
                  ),
                  TextButton(
                      onPressed: () async {
                        selectFile();
                      },
                      child: Text(
                        "Select File",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ))
                ]),
          ),
        ));
  }

  // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  //     stream: uploadTask?.snapshotEvents,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         final data = snapshot.data!;
  //         double progress = data.bytesTransferred / data.totalBytes;

  //         return SizedBox(
  //           height: MediaQuery.of(context).size.height * 1 / 10,
  //           child: Stack(
  //             fit: StackFit.expand,
  //             children: [
  //               LinearProgressIndicator(
  //                 value: progress,
  //                 backgroundColor: AppColors.grey_background,
  //                 color: AppColors.yellow_accent,
  //               ),
  //               Center(
  //                 child: Text(
  //                   '${(100 * progress).roundToDouble()}%',
  //                   style: GoogleFonts.poppins(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 15,
  //                       color: AppColors.white_text),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       } else {
  //         return const SizedBox(height: 50);
  //       }
  //     });
}
