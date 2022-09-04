import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serviz/controllers/imagePicker_controller.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';

class UploadWeekForm extends StatefulWidget {
  UploadWeekForm({Key? key}) : super(key: key);

  @override
  State<UploadWeekForm> createState() => _UploadWeekFormState();
}

class _UploadWeekFormState extends State<UploadWeekForm> {
  File? image;

  ImagePicker imagePicker = ImagePicker();

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

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
                      "Your Weekly Report",
                      style: GoogleFonts.poppins(
                          color: AppColors.white_text, fontSize: 27),
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => imagePickerController.selectedImagePath.value == ''
                    ? Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                                child: dottedBorder(context),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width - 80,
                                decoration: BoxDecoration(
                                    color: AppColors.black_background,
                                    borderRadius: BorderRadius.circular(12)))),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width - 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(imagePickerController
                                    .selectedImagePath.value),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Expanded(
                      child: Bounce(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: MediaQuery.of(context).size.height * 1 / 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.yellow_accent),
                            child: Center(
                              child: Text(
                                'Upload Image',
                                style: GoogleFonts.poppins(
                                    color: AppColors.black_background,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          duration: Duration(milliseconds: 110),
                          onPressed: () {}),
                    ),
                  ),
                )
              ],
            )
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
                    Icons.image,
                    color: AppColors.yellow_accent,
                    size: 50,
                  ),
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((context) => bottomSheet(context)));
                      },
                      child: Text(
                        "Upload Image",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ))
                ]),
          ),
        ));
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: size.height * 0.2,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Choose Image",
            style: GoogleFonts.poppins(
                color: AppColors.white_text, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Column(
                  children: [
                    Icon(Icons.image, color: AppColors.white_text),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Gallery",
                      style: GoogleFonts.poppins(color: AppColors.white_text),
                    )
                  ],
                ),
                onTap: (() {
                  imagePickerController.getImage(ImageSource.gallery);
                }),
              ),
              SizedBox(
                width: 60,
              ),
              InkWell(
                child: Column(
                  children: [
                    Icon(Icons.camera_alt_rounded, color: AppColors.white_text),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Camera",
                      style: GoogleFonts.poppins(color: AppColors.white_text),
                    )
                  ],
                ),
                onTap: (() {
                  imagePickerController.getImage(ImageSource.camera);
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future PickImage(ImageSource source) async {
    try {
      final image =
          await imagePicker.pickImage(source: source, imageQuality: 100);

      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }
}
