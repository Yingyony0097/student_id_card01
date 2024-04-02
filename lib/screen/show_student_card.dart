import 'package:flutter/material.dart';
import 'package:student_id_card/screen/search_student.dart'; // เพิ่มบรรทัดนี้
import 'package:student_id_card/screen/student_edit.dart';
import 'package:student_id_card/screen/student_add.dart';
import 'package:student_id_card/screen/search_student.dart';
import 'package:student_id_card/screen/login_page.dart'; // แก้ให้เรียกใช้ LoginPage แทน
// ignore: unused_import
import 'package:student_id_card/screen/admin_page.dart';

class ShowCard extends StatefulWidget {
  final dynamic data; // เปลี่ยนจาก Student เป็น dynamic

  const ShowCard({Key? key, required this.data}) : super(key: key);

  @override
  State<ShowCard> createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  @override
  Widget build(BuildContext context) {
    // เพิ่มการตรวจสอบประเภทข้อมูลที่รับเข้ามา
    if (widget.data is Student) {
      final student = widget.data as Student; // แปลง widget.data เป็น Student
      return Scaffold(
        backgroundColor: const Color.fromARGB(244, 57, 76, 255),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(student.images),
                  const SizedBox(height: 18),
                  const Text(
                    'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມມູນຂ່າວສານ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Institute of Infomation and Communications Technology',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "ບັດນັກສືກສາ ",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(student.images),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${student.fname_la} ${student.lname_la}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${student.fname_en} ${student.lname_en}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Text(
                          'ລະຫັດນັກສືກສາ:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          student.sdCardID,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Text(
                          'ວັນ,ດືອນ,ປີເກີດ:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          student.date_of_birth,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Text(
                          'ວັນທີ່ອອກບັດ:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          student.date_start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Text(
                          'ກຳນົດນຳໃຊ້ບັດ:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          student.date_end,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // หากข้อมูลที่รับเข้ามาไม่ใช่ Student ให้แสดงข้อความ "Invalid Data"
      return Scaffold(
        body: Center(
          child: Text(
            'Invalid Data',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
