import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowStudentScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const ShowStudentScreen({Key? key, required this.studentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.blue[900],
              ),
            ),
            Container(
              color: Colors.blue.withOpacity(0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Text(
                      'ສະຖາບັນ ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Institute Of Information and Communication Technology',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'ບັດນັກສືກສາ',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.network(
                        studentData['images'],
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${studentData['gender']} ${studentData['fname_la']} ${studentData['lname_la']}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            '${studentData['phed']} ${studentData['fname_en']} ${studentData['lname_en']}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'ລະຫັດບັດນັກສືກສາ: ${studentData['sdCardID']}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ວັນ.ເດືອນ.ປີ ເກີດ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(studentData['date_of_birth']))}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ວັນທີ່ອອກບັດ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(studentData['date_start']))}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'ກຳນົດນຳໃຊ້ບັດ: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(studentData['date_end']))}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Image.asset(
                          'assets/images/F-Darf.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
