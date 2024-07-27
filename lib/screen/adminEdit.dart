// ignore: file_names
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminEdit extends StatefulWidget {
  const AdminEdit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminEditState createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {
  final _formKey = GlobalKey<FormState>();

  late String _token;
  late String _username;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTokenAndUsername();
  }

  void _loadTokenAndUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
      _username = prefs.getString('username') ?? '';
      _usernameController.text = _username;
    });
  }

  void _updateAdmin() async {
    if (_formKey.currentState!.validate()) {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $_token';

      Map<String, dynamic> data = {
        'username': _usernameController.text,
        'password': _passwordController.text,
      };

      try {
        Response response = await dio.put(
          'http://192.168.190.62:8000/admin/$_username',
          data: jsonEncode(data),
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Update successful
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ອັບເດດຂໍ້ມູນສຳເລັດ')),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', _usernameController.text);
        } else {
          // Handle unsuccessful response
          String errorMessage = response.data['error'] ?? 'ບໍ່ສາມາດອັບເດດຂໍ້ມູນໄດ້';
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        // Handle Dio errors
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
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
                    'ແກ້ໄຂຂໍ້ມູນຜູ້ດູແລລະບົບ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 9, 9),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                _buildTextField(
                  labelText: 'ຊື່ຜູ້ດູແລລະບົບ:',
                  hintText: 'ກະລຸນາປ້ອນຊື່ທີ່ຕ້ອງການແກ້ໄຂ',
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຊື່ທີ່ຕ້ອງການແກ້ໄຂ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  labelText: 'ລະຫັດຜ່ານ:',
                  hintText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານທີຕ້ອງການແກ້ໄຂ',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານທີຕ້ອງການແກ້ໄຂ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateAdmin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 51, 255),
                    ),
                    child: const Text(
                      'ແກ້ໄຂຂໍ້ມູນຜູ້ດູແລລະບົບ',
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
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      controller: controller,
    );
  }
}
