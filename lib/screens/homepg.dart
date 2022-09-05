import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/drawer/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/widgets/progress_widget.dart';
import 'package:serviz/widgets/widget_card.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String week = "Week";

  ScrollController? _controller;

  @override
  void initState() {
    _controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        _controller?.jumpTo(
          _controller!.position.maxScrollExtent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyHomeAppBar(),
        drawer: NavigationDrawer(),
        backgroundColor: AppColors.grey_background,
        body: Column(
          children: [
            Row(
              children: [ProgressWidget()],
            ),
            Expanded(
                child: ListView.builder(
                    controller: _controller,
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: 57,
                    itemBuilder: (context, index) {
                      return WidgetCard(week: "Week" + '${index + 1}');
                    }))
          ],
        ));
  }
}
