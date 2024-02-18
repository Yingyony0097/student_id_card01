

import 'package:flutter/material.dart';
import 'package:student_id_card/screen/admin_page.dart';
import 'package:student_id_card/screen/Login_page.dart';
import 'package:student_id_card/screen/search_student_edit.dart';
import 'package:student_id_card/screen/show_studen_card.dart';
import 'package:student_id_card/screen/student_edit.dart';
import 'package:student_id_card/screen/student_add.dart';
import 'package:student_id_card/screen/search_student.dart';

class AppRoute {
  static const admin = 'adminpage';
  static const login = 'LoginPage';
  static const edit = 'StudentEdit';
  static const studentadd = 'studentAdd';
  static const search = 'Searchstudent';
  static const showCard = 'ShowCard';
  // ignore: constant_identifier_names
  static const ShowStudentEditCard = 'searchEdit';

  static get all => <String, WidgetBuilder>{
        admin: (context) => const adminpage(),
        login: (context) => const LoginPage(),
        edit: (context) => const StudentEdit(),
        studentadd: (context) => const studentAdd(),
        search: (context) => const Searchstudent(),
        showCard: (context) => const ShowCard(),
        ShowStudentEditCard: (context) => const searchEdit(),
      };
}
