import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/drawer/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/widgets/progress_widget.dart';
import 'package:serviz/widgets/widget_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String week = "Week";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: NavigationDrawer(),
        backgroundColor: AppColors.grey_background,
        body: Column(
          children: [
            Row(
              children: [ProgressWidget()],
            ),
            Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return WidgetCard(week: "Week" + '${index + 1}');
                    }))
          ],
        ));
  }
}
