import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/functions/getusername.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/utils/message_bubble.dart';
import 'package:serviz/widgets/appbar.dart';

class TeachersNotificationScreen extends StatefulWidget {
  TeachersNotificationScreen({super.key});

  @override
  State<TeachersNotificationScreen> createState() =>
      _TeachersNotificationScreenState();
}

class _TeachersNotificationScreenState
    extends State<TeachersNotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getMessages();
    super.initState();
  }

  List<String> options = ["All Groups", "G2062035", "G2"];
  var selectedOption = 'All Groups';
  final MessagetextController = TextEditingController();
  List messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBackAppBar(),
      backgroundColor: AppColors.grey_background,
      body: Stack(
        children: <Widget>[
          FutureBuilder(
              future: getMessages(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.yellow_accent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                  bottomRight: Radius.circular(18),
                                ),
                              ),
                              child: Text(
                                messages[index],
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: AppColors.black_background),
                              ),
                            ),
                          ),
                          CustomPaint(
                              painter: CustomShape(AppColors.yellow_accent)),
                        ],
                      ),
                    );
                  },
                );
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColors.black_background),
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 90,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.yellow_accent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.grey_background,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: MessagetextController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: AppColors.white_text),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: AppColors.black_background,
                                    contentTextStyle: GoogleFonts.poppins(
                                        fontSize: 35,
                                        color: AppColors.white_text),
                                    elevation: 5,
                                    actions: [
                                      // DropDownMultiSelect(
                                      //   options: controller.options,
                                      //   whenEmpty: 'Select group',
                                      //   hintStyle: GoogleFonts.poppins(
                                      //       fontSize: 15,
                                      //       color: AppColors.white_text),
                                      //   decoration: InputDecoration(
                                      //       fillColor:
                                      //           AppColors.black_background),
                                      //   onChanged: (value) {
                                      //     controller.selectedOptionList.value =
                                      //         value;
                                      //     controller.selectedOption.value = '';
                                      //     controller.selectedOptionList.value
                                      //         .forEach((element) {
                                      //       controller.selectedOption.value =
                                      //           controller
                                      //                   .selectedOption.value +
                                      //               element;
                                      //     });
                                      //   },
                                      //   selectedValues:
                                      //       controller.selectedOptionList.value,
                                      // ),
                                      // TextButton(
                                      //     onPressed: () {
                                      //       print(controller
                                      //           .selectedOption.value);

                                      //       print(
                                      //           controller.selectedOptionList);
                                      //     },
                                      //     child: Text('Send Message'))

                                      DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          focusColor: AppColors.yellow_accent,
                                          alignment:
                                              AlignmentDirectional.center,
                                          style: GoogleFonts.poppins(
                                            color: AppColors.white_text,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          dropdownColor:
                                              AppColors.black_background,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          value: selectedOption,
                                          items: options
                                              .map((item) => DropdownMenuItem(
                                                    child: Text(item),
                                                    value: item,
                                                  ))
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedOption = val.toString();
                                            });
                                          }),

                                      TextButton(
                                          onPressed: () {
                                            selectedOption == 'All Groups'
                                                ? postBroadcastmessageAllGroupsFirestore(
                                                    MessagetextController.text)
                                                : postBroadcastmesaagetoFirestore(
                                                    MessagetextController.text);
                                          },
                                          child: Text('Send Message'))
                                    ],
                                  ));
                        },
                        child: Icon(
                          Icons.send,
                          color: AppColors.grey_background,
                          size: 23,
                        ),
                        backgroundColor: AppColors.yellow_accent,
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  postBroadcastmesaagetoFirestore(String val) async {
    await FirebaseFirestore.instance
        .collection('group')
        .doc('BTCSAI22')
        .collection('group')
        .doc(selectedOption)
        .update({
      "message": FieldValue.arrayUnion([val])
    });

    Get.snackbar('Successfull', 'message sent');
  }

  postBroadcastmessageAllGroupsFirestore(String val) async {
    var collection = FirebaseFirestore.instance
        .collection('group')
        .doc('BTCSAI22')
        .collection('group');
    var querySnapshots = await collection.get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        "message": FieldValue.arrayUnion([val])
      });
    }
  }

  getMessages() async {
    await FirebaseFirestore.instance
        .collection('group')
        .doc('BTCSAI22')
        .collection('group')
        .doc('G2062035')
        .get()
        .then((data) => {
              messages = data['message'],
            });
  }
}
