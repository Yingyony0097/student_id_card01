import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentEdit extends StatefulWidget {
  final Student? student;

  const StudentEdit({Key? key, this.student}) : super(key: key);

  @override
  State<StudentEdit> createState() => _StudentEditState();
}

class _StudentEditState extends State<StudentEdit> {
  final _formKey = GlobalKey<FormState>();

  PickedFile? _image;

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

 void _pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    // ทำอะไรกับรูปที่เลือกได้ต่อไป
    setState(() {
      _image = pickedImage as PickedFile?; // กำหนดค่าให้กับตัวแปร _image
    });
  } else {
    print('No image selected.');
  }
}



  void sendDataToServer() async {
    Dio dio = Dio();
    try {
      if (_formKey.currentState!.validate()) {
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

        FormData formData = FormData.fromMap({
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
          'image': _image != null
              ? await MultipartFile.fromFile(File(_image!.path).path,
                  filename: 'user_image')
              : null,
        });

        Response response = await dio.put(
            'http://192.168.190.62:8000/student/$sdCardID',
            data: formData);

        print(response.data);
      }
    } catch (e) {
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
                  obscureText: true,
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
                  labelText: 'ຜູ້ອັບເດດ:',
                  hintText: 'ກະລຸນາປ້ອນຜູ້ອັບເດດ',
                  controller: updatedbyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຜູ້ອັບເດດ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('ເລືອກຮູບພາບ'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: sendDataToServer,
                        child: const Text('ບັນທຶກ'),
                      ),
                    ),
                  ],
                ),
                if (_image != null) ...[
                  const SizedBox(height: 20),
                  Image.file(
                    File(_image!.path),
                    height: 150,
                  ),
                ],
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
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      obscureText: obscureText,
      validator: validator,
    );
  }

  Widget _buildDateField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    void Function()? onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      validator: validator,
    );
  }

  Widget _buildYearDropdown({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
    );
  }
}

class Student {
  final String sdCardID;
  final String fnameLa;
  final String lnameLa;
  final String fnameEn;
  final String lnameEn;
  final String dateOfBirth;
  final String fieldOfStudy;
  final String year;
  final String dateStart;
  final String dateEnd;
  final String password;
  final String updatedBy;

  Student({
    required this.sdCardID,
    required this.fnameLa,
    required this.lnameLa,
    required this.fnameEn,
    required this.lnameEn,
    required this.dateOfBirth,
    required this.fieldOfStudy,
    required this.year,
    required this.dateStart,
    required this.dateEnd,
    required this.password,
    required this.updatedBy,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      sdCardID: json['sdCardID'],
      fnameLa: json['fname_la'],
      lnameLa: json['lname_la'],
      fnameEn: json['fname_en'],
      lnameEn: json['lname_en'],
      dateOfBirth: json['date_of_birth'],
      fieldOfStudy: json['field_of_study'],
      year: json['year'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      password: json['password'],
      updatedBy: json['updated_by'],
    );
  }

  
}
