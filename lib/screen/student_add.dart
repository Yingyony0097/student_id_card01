import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _birthdateController = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _lastLoginDateController = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
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
                      _birthdateController.text = formattedDate;
                    }
                  },
                  controller: _birthdateController,
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildDropdown(
                  labelText: 'ສາຂາທີຮຽນ:',
                  hintText: 'ກະລຸນາເລືອກສາຂາທີຮຽນ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາເລືອກສາຂາທີຮຽນ';
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
                      _lastLoginDateController.text = formattedDate;
                    }
                  },
                  controller: _lastLoginDateController,
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
                      _usageDateController.text = formattedDate;
                    }
                  },
                  controller: _usageDateController,
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ລະຫັດຜ່ານ:',
                  hintText: 'ກະລຸນາສ້າງລະຫັດຜ່ານ',
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
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Validate successful
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminPage(),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(192, 39, 2, 226)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: const Text(
                      'ບັນທືກຂໍ້ມູນ',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    required Function? validator,
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
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      value: _selectedMajor,
      onChanged: (newValue) {
        setState(() {
          _selectedMajor = newValue;
        });
      },
      validator: validator as String? Function(String?)?,
      items: [
        'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 1',
        'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 2',
        'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 3',
        'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 4',
        'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 1',
        'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 2',
        'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 3',
        'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 4',
        'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 1',
        'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 2',
        'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 3',
        'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 4',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

Widget _buildDateField({
  required String labelText,
  required String hintText,
  required Function? validator,
  required Function onTap,
  required TextEditingController controller,
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
