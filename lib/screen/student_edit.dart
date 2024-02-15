import 'package:flutter/material.dart';
// import 'package:student_id_card/screen/admin_page.dart';
import 'package:student_id_card/screen/routes.dart';

class StudentEdit extends StatelessWidget {
  const StudentEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 244, 247, 227),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'ກະລຸນາປ້ອນຂໍ້ມູນນັກສືກສາທີ່ຕ້ອງການເພີ່ມ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                    label: 'ລະຫັດນັກສືກສາ',
                    hintText: 'ກະລຸນາປ້ອນລະຫັດນັກສືກສາ'),
                _buildTextField(label: 'ຊື່ພາສາລາວ', hintText: 'ກະລຸນາປ້ອນຊື່'),
                _buildTextField(
                    label: 'ນາມສະກຸນພາສາລາວ', hintText: 'ກາລຸນາປ້ອນນາມສະກຸນ'),
                _buildTextField(
                    label: 'ວັນ,ເດືອນ,ປີເກີດ',
                    hintText: 'ກະລຸນາປ້ອນ ວັນ,ເດືອນ,ປີເກີດ'),
                _buildTextField(
                    label: 'ວັນທີ່ອອກບັດ',
                    hintText: 'ກະລຸນາປ້ອນວັນທີ່ອອກບັດນັກສືກສາ'),
                _buildTextField(
                    label: 'ກຳນົດນຳໃຊ້ບັດ', hintText: 'ກຳນົດການນຳໃຊ້ບັດ'),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.admin);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(192, 39, 2, 226),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text(
                    'ບັນທືກຂໍ້ມູນ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
