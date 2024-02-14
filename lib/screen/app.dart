import 'package:flutter/material.dart';
import 'package:student_id_card/screen/Login_page.dart';
import 'package:student_id_card/screen/routes.dart';

final navigatorState = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: MaterialApp(
      title: "IICT",
      routes: AppRoute.all,
      home: const LoginPage(),
      navigatorKey: navigatorState,
      debugShowCheckedModeBanner: false,
    ));
  }
}
