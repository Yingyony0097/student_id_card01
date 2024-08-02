import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_id_card/screen/admin_page.dart';

class AdminAdd extends StatefulWidget {
  const AdminAdd({Key? key}) : super(key: key);

  @override
  _AdminAddState createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  final _formKey = GlobalKey<FormState>();

  late String _token;
  Uint8List? _image;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  void _createAdmin() async {
    if (_formKey.currentState!.validate()) {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $_token';

      Map<String, dynamic> data = {
        'username': _usernameController.text,
        'password': _passwordController.text,
      };

      try {
        Response response = await dio.post(
          'http://192.168.190.62:8000/Admin',
          data: jsonEncode(data),
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Admin created successfully
          print('ສ້າງຜູ້ດູແລລະບົບສຳເລັດ');
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdminPage(),
            ),
          );
        } else {
          // Handle unsuccessful response
          String errorMessage = response.data['message'] ?? 'ບໍ່ສາມາດສ້າງຜູ້ດູແລລະບົບ';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
            ),
          );
          print('Failed to create admin user: $errorMessage');
        }
      } catch (e) {
        // Handle Dio errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
        print('Error: $e');
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
                    height: 120, // Set height as per your requirement
                    // Adjust fit and alignment as needed
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມມູນຂ່າວສານ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'ເພິ່ມຂໍ້ມູນຜູ້ດູແລລະບົບ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 9, 9),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                _buildTextField(
                  labelText: 'ຊື່ຜູ້ໃຊ້:',
                  hintText: 'ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້',
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ລະຫັດຜ່ານ:',
                  hintText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານ',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _createAdmin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 51, 255),
                    ),
                    child: const Text(
                      'ເພິ່ມຜູ້ດູແລລະບົບ',
                      style: TextStyle(color: Colors.white),
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
    required TextEditingController controller,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: validator as String? Function(String?)?,
      controller: controller,
    );
  }
}
