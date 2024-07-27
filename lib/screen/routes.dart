import 'package:flutter/material.dart';
import 'package:student_id_card/screen/search_student.dart';
import 'package:student_id_card/screen/search_student_edit.dart';
import 'package:student_id_card/screen/show_student_card.dart'; // แก้เป็น 'show_student_card.dart'
import 'package:student_id_card/screen/student_edit.dart';
import 'package:student_id_card/screen/student_add.dart';
import 'package:student_id_card/screen/search_student.dart';
import 'package:student_id_card/screen/login_page.dart'; 
import 'package:student_id_card/screen/admin_page.dart';

class AppRoute {
  static const admin = 'adminpage';
  static const login = 'login'; // แก้เป็น 'login' แทน 'LoginPage'
  static const edit = 'StudentEdit';
  static const studentadd = 'studentadd';
  static const search = 'search'; // แก้เป็น 'search' แทน 'SearchStudent'
  static const ShowCard = 'ShowCard'; // เปลี่ยนจาก 'ShowCard' เป็น 'showCard'

  static const showStudentEditCard = 'showStudentEditCard'; // แก้ชื่อเส้นทางให้ตรงกับค่าคงที่
  static const searchEdit = 'searchEdit'; // เพิ่มเส้นทาง 'searchEdit' ที่ตรงกับ 'SearchStudentEdit' ของคุณ

  static get all => <String, WidgetBuilder>{
    // โปรดแน่ใจว่าเส้นทาง 'login' ได้ถูกกำหนดใน MaterialApp ให้เรียกใช้ LoginPage
    login: (context) => const LoginPage(),
    admin: (context) => const AdminPage(),
    edit: (context) => const StudentEdit(),
    studentadd: (context) => const SearchStudent(),
    search: (context) => const SearchStudent (),
    // ShowCard: (context) => ShowCard(), // แก้เป็น ShowStudentCard() โดยไม่ใช้ const

    // showStudentEditCard: (context) => const showStudentEditCard(), // แก้เป็น 'SearchStudentEdit' และตรวจสอบให้แน่ใจว่าชื่อคลาสตรงกับชื่อไฟล์
  };
}
