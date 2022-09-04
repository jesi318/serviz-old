import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard({Key? key, required this.week}) : super(key: key);
  final String week;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/weekform');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          color: AppColors.yellow_accent,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (1 / 6),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: AppColors.yellow_accent,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Container(
                            height: 55.0,
                            child: Image.asset("assets/icons/checked.png")),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              week,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Text("Status :  ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal)),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Text("Approved",
                                    style: GoogleFonts.poppins(
                                        color: Colors.green,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
