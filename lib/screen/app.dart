import 'package:flutter/material.dart';
import 'package:student_id_card/screen/login_page.dart';
import 'package:student_id_card/screen/routes.dart';

final navigatorState = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IICT",
      routes: AppRoute.all,
      home: const LoginPage(), // กำหนดหน้าแรกเป็น LoginPage
      navigatorKey: navigatorState,
      debugShowCheckedModeBanner: false,
    );
  }
}
