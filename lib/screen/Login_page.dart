// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_id_card/screen/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(244, 244, 247, 227),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  //logo

                  Image.asset('assets/images/logo.png'),

                  //iict
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມມູນຂ່າວສານ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'ບັດນັກສືກສາເອເລັກໂຕຣນິກ',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),

                  //usertextField
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'ລະຫັດບັດນັກສືກສາ:',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'ລະຫັດບັດນັກສືກສາ'),
                        ),
                      ),
                    ),
                  ),

                  //passwordTextField

                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'ລະຫັດຜ່ານ:',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'ລະຫັດຜ່ານ'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //siginButton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(192, 39, 2, 226),
                            borderRadius: BorderRadius.circular(15)),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(192, 39, 2, 226)),
                              child: const Text(
                                'ເຂົ້າສູ່ລະບົບ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoute.admin);
                              }),
                        ),
                      ),
                    ),
                  ),

                  //
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 30,
                    ),
                  ),

                  const Text(
                    'ຂໍ້ມູນຕິດຕໍ່: 021 312431, ເວັບໄຊ້ :iict.gov.la',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),

                  const Text(
                    'ສະຖານທີ່: ຖະໜົນມິດຕະພາບ ລາວ-ໄທ, ບ້ານວັດນາກມ',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                  const Text(
                    'ເມືອງສີສັດຕະນາກ, ນະຄອນຫຼວງວຽງຈັນ',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
