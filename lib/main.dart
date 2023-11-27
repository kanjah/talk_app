import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:talk_app/authenticationScreen/login_screen.dart';
import 'package:talk_app/controllers/authentication_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize firebase
  await Firebase.initializeApp().then((value) {
    //initialize the AuthenticationController from authentication_controller.dart
    Get.put(AuthenticationController());
  });

  //Asking for permisions to push notifications
  await Permission.notification.isDenied.then((value) {
    //If not allowed as for permision
    if (value) {
      Permission.notification.request();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',

      //Background theme
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
