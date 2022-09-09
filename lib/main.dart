import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serviz/auth_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:serviz/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
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
      initialRoute: '/login',
      getPages: appRoutes(),
    );
  }
}
