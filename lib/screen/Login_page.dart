import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_id_card/screen/admin_page.dart';
import 'package:student_id_card/screen/student_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(244, 244, 247, 227),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: _LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadUsernameFromSharedPreferences();
  }

  Future<void> _loadUsernameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      _usernameController.text = username;
    }
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      var response = await Dio().post(
        'http://192.168.205.62:8000/admin/login',
        data: {
          "username": username,
          "password": password
        }
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        var isAdmin = responseData['isAdmin'];
        var token = responseData['token'];
        var studentData = responseData['studentData'];

        // Save username, isAdmin status, and token to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setBool('isAdmin', isAdmin);
        await prefs.setString('token', token);

        if (!isAdmin) {
          // Store student data in SharedPreferences
          await prefs.setString('student_data', jsonEncode(studentData));
        }

        // Navigate to appropriate page based on isAdmin status
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => isAdmin ? AdminPage() : StudentPage(),
          ),
        );
      }
    } catch (e) {
      // Handle login error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to login. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTextField(
    String hintText,
    bool isPassword,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(_isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
            ),
            onChanged: (value) {
              if (controller == _usernameController) {
                _saveUsernameToSharedPreferences(value);
              }
            },
            validator: validator,
          ),
        ),
      ),
    );
  }

  void _saveUsernameToSharedPreferences(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Widget _buildButton(String buttonText, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(192, 39, 2, 226),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(192, 39, 2, 226),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/logo.png'),
          const SizedBox(height: 20),
          const Text(
            'ສະຖາບັນ ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'ລະຫັດບັດນັກສືກສາ:',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildTextField(
            'ກະລຸນາປ້ອນລະຫັດບັດນັກສືກສາ',
            false,
            _usernameController,
            (value) {
              if (value == null || value.isEmpty) {
                return 'ກະລຸນາປ້ອນລະຫັດບັດນັກສືກສາ';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'ລະຫັດຜ່ານ:',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildTextField(
            'ກະລຸນາປ້ອນລະຫັດຜ່ານ',
            true,
            _passwordController,
            (value) {
              if (value == null || value.isEmpty) {
                return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
_buildButton('ເຂົ້າສູ່ລະບົບ', _login),
const SizedBox(height: 20),
],
),
);
}
}

void main() {
runApp(const MaterialApp(
home: LoginPage(),
));
}
