import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions/get_regno.dart';
import '../utils/colors.dart';

class UploadDocWidget extends StatefulWidget {
  const UploadDocWidget({super.key});

  @override
  State<UploadDocWidget> createState() => _UploadDocWidgetState();
}

class _UploadDocWidgetState extends State<UploadDocWidget> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  bool? uploaded;
  String ss = "";
  s() async {
    var sv = await GetRegNo(documentID: useruid).getcollectiongrpno();
    ss = sv;
  }

  Future uploadFile() async {
    final path = 'files/${ss}/${pickedFile!.name}';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 19,
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
                            height: MediaQuery.of(context).size.height * 0.3,
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
    );
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
}
