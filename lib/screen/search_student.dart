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

      var response = await _dio.get(
        'http://192.168.205.62:8000/student/$sdCardID',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null) {
          try {
            Map<String, dynamic> studentData = responseData;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ShowStudentScreen(studentData: studentData),
              ),
            );
          } catch (e) {
            print('Error parsing student data: $e');
          }
        } else {
          print('No student found');
        }
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      // ignore: use_build_context_synchronously
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
                'ສະຖາບັນ ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ',
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
                        labelText: 'ກະລຸນາໃສ່ລະຫັດບັດນັກສືກສາ',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                      try {
                        await _searchStudent(_searchController.text, token);
                      } catch (e) {
                        print('Error searching student: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(192, 39, 2, 226), // Set the button color to blue
                    ),
                    child: const Text('ຄົ້ນຫາ',
                    style: TextStyle(color: Color.fromARGB(219, 255, 255, 255)),)
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
