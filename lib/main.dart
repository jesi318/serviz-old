import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviz/routes.dart';

import 'screens/create_join_group.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serviz/screens/homepg.dart';
import 'firebase_options.dart';
import 'package:serviz/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'serviz',
      initialRoute: '/welcome',
      getPages: appRoutes(),
    );
  }
}
