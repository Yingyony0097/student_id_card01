import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_id_card/screen/show_student_card.dart';

class SearchStudent extends StatefulWidget {
  const SearchStudent({Key? key}) : super(key: key);

  @override
  State<SearchStudent> createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  late TextEditingController _searchController;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchStudent(String sdCardID, String? token) async {
    try {
      if (sdCardID.isEmpty) {
        throw Exception('Please enter a valid sdCardID');
      }
     
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var dio = Dio();
      var response = await dio.get(
        'http://192.168.0.193:8000/student/',
        queryParameters: {'sdCardID': sdCardID},
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        if (responseData.runtimeType == Map) {
          final student = Student.fromJson(responseData);
         
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowCard(data: student),
            ),
          );

        } else if (responseData.runtimeType == List) {
          // วนลูปผ่าน List และสร้างอ็อบเจกต์ Student จากข้อมูลแต่ละองค์ประกอบ
          List<Student> students = [];
          for (var studentData in responseData) {
            students.add(Student.fromJson(studentData));
          }
          // ในที่นี้คุณสามารถทำตามความเหมาะสม ยกตัวอย่างเช่นการแสดงรายชื่อนักเรียนทั้งหมด
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to load data. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 244, 247, 227),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 18),
              const Text(
                'Search Student',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Student ID',
                        labelStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? token = prefs.getString('token');
                      await _searchStudent(_searchController.text, token);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(192, 39, 2, 226)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Student {
  final String images;
  final String sdCardID;
  final String fname_la;
  final String lname_la;
  final String fname_en;
  final String lname_en;
  final String date_of_birth;
  final String date_start;
  final String date_end;

  Student({
    required this.images,
    required this.sdCardID,
    required this.fname_la,
    required this.lname_la,
    required this.fname_en,
    required this.lname_en,
    required this.date_of_birth,
    required this.date_start,
    required this.date_end,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      images: json['images'],
      sdCardID: json['sdCardID'],
      fname_la: json['fname_la'],
      lname_la: json['lname_la'],
      fname_en: json['fname_en'],
      lname_en: json['lname_en'],
      date_of_birth: json['date_of_birth'],
      date_start: json['date_start'],
      date_end: json['date_end'],
    );
  }
}
