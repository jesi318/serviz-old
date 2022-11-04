import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class GrouplistWidgetCard extends StatefulWidget {
  GrouplistWidgetCard({Key? key, required this.grp}) : super(key: key);

  String grp;

  @override
  State<GrouplistWidgetCard> createState() => _GrouplistWidgetCardState();
}

class _GrouplistWidgetCardState extends State<GrouplistWidgetCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            height: MediaQuery.of(context).size.height * (1 / 15),
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
                            height: 50.0,
                            child: Image.asset("assets/icons/group.png")),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        widget.grp,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
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
