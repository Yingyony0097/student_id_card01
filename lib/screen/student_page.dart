import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_id_card/screen/Login_page.dart';
import 'package:student_id_card/screen/show_student_card.dart'; // Import ShowStudentScreen

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _getToken(); // Call method to get token when the widget initializes
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token'); // Get token from SharedPreferences
    });
    print('Token retrieved: $_token'); // Debug print
  }

  Future<void> _fetchAndStoreStudentData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? studentJson = prefs.getString('student_data');
      if (studentJson != null) {
        Map<String, dynamic> studentData = json.decode(studentJson);
        print('Student data retrieved from SharedPreferences: $studentData'); // Debug print
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowStudentScreen(studentData: studentData),
          ),
        );
      } else {
        print('Student data not found in SharedPreferences'); // Debug print
        throw Exception('Student data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching student data from SharedPreferences: $e'); // Debug print
      // Handle error fetching student data from SharedPreferences
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 244, 247, 227),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 20),
                const Text(
                  'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມູນຂ່າວສານ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                if (_token != null && _token!.isNotEmpty)
                  _buildButton('ເບິ່ງບັດນັກສືກສາ', _fetchAndStoreStudentData), // Call _fetchAndStoreStudentData when button is pressed
                const SizedBox(height: 280),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(192, 178, 177, 183),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        "ອອກຈາກລະບົບ",
                        style: TextStyle(
                          color: Color.fromARGB(253, 255, 250, 250),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Button Widget
  Widget _buildButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(192, 39, 2, 226),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
