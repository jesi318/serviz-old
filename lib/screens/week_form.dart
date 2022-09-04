import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serviz/controllers/imagePicker_controller.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';

class UploadWeekForm extends StatelessWidget {
  UploadWeekForm({Key? key}) : super(key: key);

  File? pickedFile;
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Obx(
                      () => ImagePickerController().selectedImagePath.value ==
                              ''
                          ? Container(
                              child: dottedBorder(context),
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: BoxDecoration(
                                  color: AppColors.black_background,
                                  borderRadius: BorderRadius.circular(12)))
                          : Image.file(File(
                              ImagePickerController().selectedImagePath.value)),
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
                  ImagePickerController().getImage(ImageSource.gallery);
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
                  ImagePickerController().getImage(ImageSource.camera);
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Future<void> takePhoto(ImageSource source) async {
  //   final pickedImage =
  //       await imagePicker.pickImage(source: source, imageQuality: 100);

  //   pickedFile = File(pickedImage!.path);
  //   imagePickerController.setImagePath(pickedFile!.path);
  // }
}
