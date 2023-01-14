import 'package:flutter/material.dart';
import 'package:serviz/utils/colors.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class ExpansionTileCard extends StatelessWidget {
  final String projectTitle;
  final String projectDescription;

  const ExpansionTileCard(
      {super.key,
      required this.projectTitle,
      required this.projectDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapToExpand(
        boxShadow: [
          BoxShadow(
            color: AppColors.black_background,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: AppColors.black_background,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
        color: AppColors.black_background,
        scrollPhysics: BouncingScrollPhysics(),
        content: Column(
          children: <Widget>[
            Text(
              projectDescription,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        title: Text(
          projectTitle,
          style: TextStyle(
            color: AppColors.yellow_accent,
            fontSize: 20,
          ),
        ),
        onTapPadding: 10,
        closedHeight: 80,
        scrollable: true,
        borderRadius: 15,
        openedHeight: 200,
      ),
    );
  }
}
