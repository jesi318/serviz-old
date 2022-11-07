import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/teachers_drawer/buildHeader.dart';
import 'package:serviz/widgets/teachers_drawer/buildListItem.dart';

class TeachersNavigationDrawer extends StatelessWidget {
  const TeachersNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(80),
                bottomRight: Radius.circular(10))),
        backgroundColor: AppColors.grey_background,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildListItems(context),
            ],
          ),
        ));
  }
}
