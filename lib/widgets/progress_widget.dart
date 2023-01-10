import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/colors.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Card(
        color: AppColors.yellow_accent,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (1 / 5),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: AppColors.yellow_accent,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CircularPercentIndicator(
                        radius: 50,
                        lineWidth: 20,
                        percent: 0.40,
                        progressColor: AppColors.black_background,
                        backgroundColor: Colors.white54,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          '40 %',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ),
                    Text(
                      'Your Overall Progress',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
