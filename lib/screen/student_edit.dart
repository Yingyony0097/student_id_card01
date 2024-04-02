import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_id_card/screen/admin_page.dart';
import 'package:student_id_card/screen/class/it03.dart';
import 'package:student_id_card/screen/utils.dart';

class StudentEdit extends StatefulWidget {
  final Student? student;

  const StudentEdit({Key? key, this.student}) : super(key: key);
  @override
  State<StudentEdit> createState() => _StudentEditState();
}

class _StudentEditState extends State<StudentEdit> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedMajor;
  int? _selectedYear;
  File? _imageFile;
  Uint8List? _image;

  TextEditingController sdCardIDController = TextEditingController();
  TextEditingController fnameLaController = TextEditingController();
  TextEditingController lnameLaController = TextEditingController();
  TextEditingController fnameEnController = TextEditingController();
  TextEditingController lnameEnController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController datestartController = TextEditingController();
  TextEditingController dateendController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();
  TextEditingController updatedbyController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
   void sendDataToServer() async {
    Dio dio = Dio();
    try {
      if (_formKey.currentState!.validate()) {
        // ดึงข้อมูลจากฟอร์ม
        String sdCardID = sdCardIDController.text;
        String fname_la = fnameLaController.text;
        String lname_la = lnameLaController.text;
        String fname_en = fnameEnController.text;
        String lname_en = lnameEnController.text;
        String date_of_birth = birthdateController.text;
        String field_of_study = fieldOfStudyController.text;
        String year = yearController.text;
        String date_start = datestartController.text;
        String date_end = dateendController.text;
        String password = passwordController.text;
        String updated_by = updatedbyController.text;

        // ส่งข้อมูลไปยังเซิร์ฟเวอร์
        Response response = await dio.put('http://192.168.0.191:8000/student/', data: {
          'sdCardID': sdCardID,
          'fname_la': fname_la,
          'lname_la': lname_la,
          'fname_en': fname_en,
          'lname_en': lname_en,
          'date_of_birth': date_of_birth,
          'field_of_study': field_of_study,
          'year': year,
          'date_start': date_start,
          'date_end': date_end,
          'password': password,
          'updated_by': updated_by,
        });

        // ดำเนินการเพิ่มเติมหลังจากได้รับการตอบกลับจากเซิร์ฟเวอร์
        print(response.data);
      }
    } catch (e) {
      // จัดการข้อผิดพลาดหากเกิดข้อผิดพลาดขณะส่งข้อมูล
      print('Error sending data to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 238, 238, 238),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'ການປ້ອນຂໍ້ມູນນັກສືກສາທີ່ຕ້ອງການແກ້ໄຂ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 35),
                _buildTextField(
                  labelText: 'ລະຫັດນັກສືກສາ:',
                  hintText: 'ກະລຸນາປ້ອນລະຫັດນັກສືກສາ',
                  controller: sdCardIDController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດນັກສືກສາ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຊື່ພາສາລາວ:',
                  hintText: 'ກະລຸນາປ້ອນຊື່',
                  controller: fnameLaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຊື່';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ນາມສະກຸນພາສາລາວ:',
                  hintText: 'ກາລຸນາປ້ອນນາມສະກຸນ',
                  controller: lnameLaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນນາມສະກຸນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຊື່ພາສາອັງກິດ:',
                  hintText: 'ກະລຸນາປ້ອນຊື່',
                  controller: fnameEnController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຊື່';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ນາມສະກຸນພາສາອັງກິດ:',
                  hintText: 'ກະລຸນາປ້ອນນາມສະກຸນ',
                  controller: lnameEnController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນນາມສະກຸນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ວັນ,ເດືອນ,ປີເກີດ:',
                  hintText: 'ກະລຸນາປ້ອນ ວັນ,ເດືອນ,ປີເກີດ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນ ວັນ,ເດືອນ,ປີເກີດ';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                      birthdateController.text = formattedDate;
                    }
                  },
                  controller: birthdateController,
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildDropdown(
                  labelText: 'ສາຂາທີຮຽນ:',
                  hintText: 'ກະລຸນາເລືອກສາຂາທີຮຽນ',
                  controller: fieldOfStudyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາເລືອກສາຂາທີຮຽນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildYearDropdown(
                  labelText: 'ປີຮຽນ:',
                  hintText: 'ກະລຸນາເລືອກປີທີຮຽນ',
                  controller: yearController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາເລືອກປີທີຮຽນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ວັນທີ່ອອກບັດ:',
                  hintText: 'ກະລຸນາປ້ອນວັນທີ່ອອກບັດນັກສືກສາ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນວັນທີ່ອອກບັດນັກສືກສາ';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                      datestartController.text = formattedDate;
                    }
                  },
                  controller: datestartController,
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ກຳນົດນຳໃຊ້ບັດ:',
                  hintText: 'ກຳນົດການນຳໃຊ້ບັດ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນກຳນົດນຳໃຊ້ບັດ';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                      dateendController.text = formattedDate;
                    }
                  },
                  controller: dateendController,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ລະຫັດຜ່ານ:',
                  hintText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານ',
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຜູ້ປ່ຽນ:',
                  hintText: 'ກະລຸນາປ້ອນຜູ້ປ່ຽນ',
                  controller: updatedbyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຜູ້ປ່ຽນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        sendDataToServer();
                      }
                    },
                    child: const Text('ບັນທຶກ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }

  Widget _buildDateField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required GestureTapCallback onTap,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: onTap,
          child: const Icon(Icons.calendar_today),
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: _selectedMajor,
      onChanged: (newValue) {
        setState(() {
          _selectedMajor = newValue;
        });
      },
      validator: validator,
      items: [
        'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT)',
        'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT)',
        'ຄວາມປອດໄພທາງໄຊເບີ (CB)',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

 Widget _buildYearDropdown({
  required String labelText,
  required String hintText,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return DropdownButtonFormField<int>(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    value: _selectedYear,
    onChanged: (int? newValue) {
      setState(() {
        _selectedYear = newValue;
      });
    },
    items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text('ປີ $value'),
      );
    }).toList(),
  
  );
}
}
