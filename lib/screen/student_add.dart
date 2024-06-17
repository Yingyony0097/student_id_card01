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
  // ignore: library_private_types_in_public_api
  _StudentAddState createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedMajor;
  String? _selectedYear;
  String? _selectedPhed;
  String? _selectedGender;
  late String _token;
  Uint8List? _image;

  final TextEditingController _sdCardIDController = TextEditingController();
  final TextEditingController __genderController = TextEditingController();
  final TextEditingController _phedController = TextEditingController();
  final TextEditingController _fnameLaController = TextEditingController();
  final TextEditingController _lnameLaController = TextEditingController();
  final TextEditingController _fnameEnController = TextEditingController();
  final TextEditingController _lnameEnController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _imagesController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _createdByController = TextEditingController();
  final TextEditingController _updatedByController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  
  get floatingActionButton => null;

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
      if (_formKey.currentState!.validate()) {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาเลือกรูปภาพ'),
        ),
      );
      return;
    }
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $_token';

      Map<String, dynamic> data = {
        'sdCardID': _sdCardIDController.text,
        'gender': __genderController.text,
        'fname_la': _fnameLaController.text,
        'lname_la': _lnameLaController.text,
        'phed': _phedController.text,
        'fname_en': _fnameEnController.text,
        'lname_en': _lnameEnController.text,
        'date_of_birth': _dateOfBirthController.text,
        'date_start': _dateStartController.text,
        'date_end': _dateEndController.text,
        'images': _image,
        'password': _passwordController.text,
        'created_by': _createdByController.text,
        'updated_by': _updatedByController.text,
        'field_of_study': _fieldOfStudyController.text,
        'year': _yearController.text,
      };
      

      try {
        Response response = await dio.post(
          'http://192.168.43.127:8000/student/',
          data: data,
        );
        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminPage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ການສ້າງນັກຮຽນບໍ່ສຳເລັດ'),
            ),
          );
        }
        
      } catch (e) {
        // Handle different error cases
        // ignore: deprecated_member_use
        if (e is DioError) {
          if (e.response != null && e.response!.statusCode == 413) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ขนาดข้อมูลที่ส่งเกินกว่าที่เซิร์ฟเวอร์อนุญาต'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
              ),
            );
          }
        }
      }
    }
  }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _birthdateController = TextEditingController();
    TextEditingController _lastLoginDateController = TextEditingController();
    TextEditingController _usageDateController = TextEditingController();
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
                  'ກະລຸນາປ້ອນຂໍ້ມູນນັກສືກສາທີ່ຕ້ອງການເພີ່ມ',
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
                  controller: _sdCardIDController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດນັກສືກສາ';
                    }
                    return null;
                  },
                ),
                _buildGenderDropdown(
                  labelText: 'ເພດ:',
                  hintText: 'ກະລຸນາເລືອກເພດ',
                  value: _selectedGender,
                  controller: _sdCardIDController,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  validator: null,
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
                  hintText: 'ກາລຸນາປ້ອນນາມສະກຸນ',
                  controller: _lnameLaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນນາມສະກຸນ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildPhedDropdown(
                  labelText: 'ເພດ:',
                  hintText: 'ກະລຸນາເລືອກເພດ',
                  value: _selectedPhed,
                  controller: _sdCardIDController,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPhed = newValue;
                    });
                  },
                  validator: null,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຊື່ພາສາອັງກິດ:',
                  hintText: 'ກະລຸນາປ້ອນຊື່',
                  controller: _fnameEnController,
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
                  controller: _lnameEnController,
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
                      _dateOfBirthController.text = formattedDate;
                    }
                  },
                  controller: _dateOfBirthController,
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildDropdown(
                  labelText: 'ສາຂາທີຮຽນ:',
                  hintText: 'ກະລຸນາເລືອກສາຂາທີຮຽນ',
                  value: _selectedMajor,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedMajor = newValue;
                    });
                  },
                  validator: null,
                ),
                const SizedBox(height: 25),
                _buildYearDropdown(
                  labelText: 'ປີຮຽນ:',
                  hintText: 'ກະລຸນາເລືອກປີຮຽນ',
                  value: _selectedYear,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedYear = newValue;
                    });
                  },
                  validator: null,
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
                      _dateStartController.text = formattedDate;
                    }
                  },
                  controller: _dateStartController,
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
                      _dateEndController.text = formattedDate;
                    }
                  },
                  controller: _dateEndController,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ລະຫັດຜ່ານ:',
                  hintText: 'ກະລຸນາສ້າງລະຫັດຜ່ານ',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຜູ້ສ້າງນັກສືກສາ:',
                  hintText: 'ກະລຸນາໃສ່ຊື່ແອັດມິນ',
                  controller: _createdByController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຜູ້ສ້າງນັກສືກສາ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ຜູ້ແກ້ໄຂນັກສືກສາ:',
                  hintText: 'ກະລຸນາໃສ່ຊື່ແອັດມິນ',
                  controller: _updatedByController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຜູ້ແກ້ໄຂນັກສືກສາ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  // ไม่ใช่ const Row
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'ອັບໂຫຼດຮູບບັດປະຈຳຕົວ:',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 120, // กำหนดความกว้างของรูปภาพ
                            height: 120, // กำหนดความสูงของรูปภาพ
                            color: Colors.grey.withOpacity(0.4),
                            child: _image != null
                                ? Image.memory(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://www.creativefabrica.com/wp-content/uploads/2021/05/26/Man-avatar-icon-vector-flat-Graphics-12541925-1-1-580x387.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: -18,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                onPressed: _createStudent,
                child: Icon(Icons.add),
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

Widget _buildTextField({
  required String labelText,
  required String hintText,
  required Function? validator,
  required TextEditingController controller,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    validator: validator as String? Function(String?)?,
  );
}

Widget _buildDropdown({
  required String labelText,
  required String hintText,
  required Function? validator,
  required String? value,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    value: value,
    onChanged: onChanged,
    validator: validator as String? Function(String?)?,
    items: const [
      DropdownMenuItem<String>(
        value: 'it',
        child: Text('ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT)'),
      ),
      DropdownMenuItem<String>(
        value: 'ict',
        child: Text('ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT)'),
      ),
      DropdownMenuItem<String>(
        value: 'cb',
        child: Text('ຄວາມປອດໄພທາງໄຊເບີ (CB)'),
      ),
    ],
  );
}

Widget _buildYearDropdown({
  required String labelText,
  required String hintText,
  required Function? validator,
  required String? value,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    value: value,
    onChanged: onChanged,
    validator: validator as String? Function(String?)?,
    items: [
      '1',
      '2',
      '3',
      '4',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _buildDateField({
  required String labelText,
  required String hintText,
  required Function? validator,
  required TextEditingController controller,
  required Function onTap,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    validator: validator as String? Function(String?)?,
    onTap: onTap as void Function()?,
    controller: controller,
  );
}

Widget _buildGenderDropdown({
  required String labelText,
  required String hintText,
  required Function? validator,
  required String? value,
  required Function(String?) onChanged, required TextEditingController controller,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    value: value,
    onChanged: onChanged,
    validator: validator as String? Function(String?)?,
    items: const [
      DropdownMenuItem<String>(
        value: 'ທ້າວ',
        child: Text('ທ້າວ'),
      ),
      DropdownMenuItem<String>(
        value: 'ນາງ',
        child: Text('ນາງ'),
      ),
    ],
  );
}

Widget _buildPhedDropdown({
  required String labelText,
  required String hintText,
  required Function? validator,
  required String? value,
  required Function(String?) onChanged, required TextEditingController controller,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: const OutlineInputBorder(),
    ),
    value: value,
    onChanged: onChanged,
    validator: validator as String? Function(String?)?,
    items: const [
      DropdownMenuItem<String>(
        value: 'MR',
        child: Text('MR'),
      ),
      DropdownMenuItem<String>(
        value: 'Miss',
        child: Text('Miss'),
      ),
    ],
  );
}
