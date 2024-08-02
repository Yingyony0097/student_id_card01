import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_id_card/screen/admin_page.dart';
import 'package:student_id_card/screen/utils.dart';

class StudentAdd extends StatefulWidget {
  const StudentAdd({Key? key}) : super(key: key);

  @override
  _StudentAddState createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedMajor;
  String? _selectedNumber;
  String? _selectedYear;
  String? _selectedGender;
  late String _token;
  Uint8List? _image;

  final TextEditingController _sdCardIDController = TextEditingController();
  final TextEditingController _fnameLaController = TextEditingController();
  final TextEditingController _lnameLaController = TextEditingController();
  final TextEditingController _fnameEnController = TextEditingController();
  final TextEditingController _lnameEnController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _createdByController = TextEditingController();
  final TextEditingController _updatedByController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  void _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
    });
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  void _createStudent() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $_token';

      FormData formData = FormData.fromMap({
        'sdCardID': _sdCardIDController.text,
        'gender': _selectedGender,
        'fname_la': _fnameLaController.text,
        'lname_la': _lnameLaController.text,
        'fname_en': _fnameEnController.text,
        'lname_en': _lnameEnController.text,
        'date_of_birth': _dateOfBirthController.text,
        'date_start': _dateStartController.text,
        'date_end': _dateEndController.text,
        'file': MultipartFile.fromBytes(_image!, filename: 'student_image.jpg'),
        'password': _passwordController.text,
        'created_by': _createdByController.text,
        'updated_by': _updatedByController.text,
        'name_field_of_study': _selectedMajor,
        'year': _selectedYear,
      });

      try {
        Response response = await dio.post(
          'http://192.168.205.62:8000/student/create',
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
        );

        if (response.statusCode == 201) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create student: ${response.data['error']}')),
          );
        }
      } catch (e) {
        if (e is DioError) {
          if (e.response != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.response!.statusMessage}')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected error: $e')),
          );
        }
      }
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
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມູນຂ່າວສານ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'ກະລຸນາປ້ອນຂໍ້ມູນນັກສືກສາທີ່ຕ້ອງການເພີ່ມ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 15, 15),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                _buildTextField(
                  labelText: 'ລະຫັດນັກສືກສາ:',
                  hintText: 'ກະລຸນາປ້ອນລະຫັດນັກສືກສາ',
                  controller: _sdCardIDController,
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
                  controller: _fnameLaController,
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
                  controller: _lnameLaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນນາມສະກຸນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildGenderDropdown(
                  labelText: 'ເພດ:',
                  hintText: 'ກະລຸນາເລືອກເພດ',
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ວັນເດືອນປີເກີດ:',
                  hintText: 'ກະລຸນາໃສ່ວັນເດືອນປີເກີດ',
                  controller: _dateOfBirthController,
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ວັນທີອອກບັດ:',
                  hintText: 'ກະລຸນາໃສ່ວັນທີ່ອອກບັດ',
                  controller: _dateStartController,
                ),
                const SizedBox(height: 25),
                _buildDateField(
                  labelText: 'ກຳນົດນຳໃຊ້ບັດ:',
                  hintText: 'ກະລຸນາໃສ່ກຳນົດນຳໃຊ້ບັດ',
                  controller: _dateEndController,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ລະຫັດຜ່ານ:',
                  hintText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານ',
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຜູ້ສ້າງນັກສືກສາ:',
                  hintText: 'ກະລຸນາປ້ອນຜູ້ສ້າງນັກສືກສາ',
                  controller: _createdByController,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຜູ້ແກ້ໄຂນັກສືກສາ:',
                  hintText: 'ກະລຸນາປ້ອນຜູ້ແກ້ໄຂນັກສືກສາ',
                  controller: _updatedByController,
                ),
                const SizedBox(height: 25),
                _buildDropdownField(
                  labelText: 'ສາຂາ:',
                  hintText: 'ກະລຸນາເລືອກສາຂາ',
                  items: ['ວິສະວະກຳ ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ', 'ວິສະວະກຳ ເຕັກໂນໂລຊີຂໍ້ມູນຂ່າວສານ', 'ວິສະວະກຳ ເຕັກໂນໂລຊີການສື່ສານ', 'ບໍລິຫານ ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ', 'ຄວາມປອດໄພທາງໄຊເບີ'], // ปรับเป็นข้อมูลจริง
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMajor = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                _buildDropdownField(
                  labelText: 'ປີຮຽນ:',
                  hintText: 'ກະລຸນາເລືອກປີຮຽນ',
                  items: ['1', '2', '3', '4'], // ปรับเป็นข้อมูลจริง
                  onChanged: (String? value) {
                    setState(() {
                      _selectedYear = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                _buildUploadImageButton(),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: _createStudent,
                    child: const Text('ເພີ່ມນັກສືກສາ'),
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
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String labelText,
    required String hintText,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'ກະລຸນາເລືອກ $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDateField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2101),
        );

        if (selectedDate != null) {
          controller.text = '${selectedDate.toLocal()}'.split(' ')[0];
        }
      },
    );
  }

  Widget _buildGenderDropdown({
    required String labelText,
    required String hintText,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      items: ['Male', 'Female', 'Other'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'ກະລຸນາເລືອກເພດ';
        }
        return null;
      },
    );
  }

  Widget _buildUploadImageButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: selectImage,
          child: const Text('ເລືອກຮູບພາບ'),
        ),
        const SizedBox(width: 20),
        _image != null
            ? Image.memory(
                _image!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : const Text('ບໍ່ມີຮູບພາບເລືອກ'),
      ],
    );
  }
}
