import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Student {
  final String sdCardID;
  final String fnameLa;
  final String lnameLa;
  final String fnameEn;
  final String lnameEn;
  final String gender;
  final String dateOfBirth;
  final String dateStart;
  final String dateEnd;
  final String password;
  final String name_field_of_study;
  final String number;
  final String updatedBy;

  Student({
    required this.sdCardID,
    required this.fnameLa,
    required this.lnameLa,
    required this.fnameEn,
    required this.lnameEn,
    required this.gender,
    required this.dateOfBirth,
    required this.dateStart,
    required this.dateEnd,
    required this.password,
    required this.name_field_of_study,
    required this.number,
    required this.updatedBy,
  });
}

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
  // TextEditingController genderController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController datestartController = TextEditingController();
  TextEditingController dateendController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController name_field_of_studyController = TextEditingController();
  TextEditingController updatedbyController = TextEditingController();
  TextEditingController numberController = TextEditingController();

   String? _selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      // Initialize controllers with data from the student object
      sdCardIDController.text = widget.student!.sdCardID;
      fnameLaController.text = widget.student!.fnameLa;
      lnameLaController.text = widget.student!.lnameLa;
      fnameEnController.text = widget.student!.fnameEn;
      lnameEnController.text = widget.student!.lnameEn;
      // genderController.text = widget.student!.gender;
      birthdateController.text = widget.student!.dateOfBirth;
      datestartController.text = widget.student!.dateStart;
      dateendController.text = widget.student!.dateEnd;
      passwordController.text = widget.student!.password;
      name_field_of_studyController.text = widget.student!.name_field_of_study;
      numberController.text = widget.student!.number;
      updatedbyController.text = widget.student!.updatedBy;
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage as PickedFile?;
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
        String gender = _selectedGender ?? '';
        String date_of_birth = birthdateController.text;
        String name_field_of_study = name_field_of_studyController.text;
        String number = numberController.text;
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
          'gender': gender,
          'date_of_birth': date_of_birth,
          'name_field_of_study': name_field_of_study,
          'number': number,
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
                  hintText: 'ກະລຸນາປ້ອນນາມສະກຸນ',
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
                _buildDropdownField(
                  labelText: 'ເພດ:',
                  hintText: 'ກະລຸນາເລືອກເພດ',
                  value: _selectedGender,
                  items: ['Male', 'Female'],
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
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
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ວັນທີອອກບັດ:',
                  hintText: 'ກະລຸນາປ້ອນ ວັນທີອອກບັດ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນ ວັນທີອອກບັດ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ກຳນົດນຳໃຊ້ບັດ:',
                  hintText: 'ກະລຸນາປ້ອນ ກຳນົດນຳໃຊ້ບັດ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນ ກຳນົດນຳໃຊ້ບັດ';
                    }
                    return null;
                  },
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
                  labelText: 'ສາຂາຮຽນ:',
                  hintText: 'ກະລຸນາປ້ອນສາຂາຮຽນ',
                  controller: name_field_of_studyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນສາຂາຮຽນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ປີຮຽນ:',
                  hintText: 'ກະລຸນາປ້ອນປີຮຽນ',
                  controller: numberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນປີຮຽນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຜູ້ແກ້ໄຂ:',
                  hintText: 'ກະລຸນາປ້ອນຜູ້ແກ້ໄຂ',
                  controller: updatedbyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຜູ້ແກ້ໄຂ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                InkWell(
                  onTap: _pickImage,
                  child: _image == null
                      ? Image.asset('assets/placeholder.png', height: 150)
                      : Image.file(File(_image!.path), height: 150),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendDataToServer();
                    }
                  },
                  child: const Text('ບັນທືກ'),
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
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validator,
    );
  }

  Widget _buildDateField({
    required String labelText,
    required String hintText,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: birthdateController,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}


Widget _buildDropdownField({
    required String labelText,
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'ກະລຸນາເລືອກເພດ';
        }
        return null;
      },
    );
  }

