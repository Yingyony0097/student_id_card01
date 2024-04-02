import 'package:flutter/material.dart';
import 'package:student_id_card/screen/Login_page.dart';
import 'package:student_id_card/screen/search_student.dart';
import 'package:student_id_card/screen/search_student_edit.dart';
import 'package:student_id_card/screen/student_add.dart';
import 'package:student_id_card/screen/student_edit.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

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
              primary: const Color.fromARGB(192, 39, 2, 226),
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
                  'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມມູນຂ່າວສານ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                _buildButton('ຄົ້ນຫາບັດນັກສືກສາ', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchStudent()),
                  );
                }),
                _buildButton('ເພີ່ມນັກສືກສາ', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentAdd()),
                  );
                }),
                _buildButton('ແກ້ໄຂຂໍ້ມູນນັກສືກສາ', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchEdit()),
                  );
                }),
                const SizedBox(height: 100),
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
                        backgroundColor: const Color.fromARGB(192, 178, 177, 183),
                      ),
                      onPressed: () {
                        // Navigate to LoginPage instead of calling signoutprocess()
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
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
}