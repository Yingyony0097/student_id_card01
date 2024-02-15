import 'package:flutter/material.dart';

import 'package:student_id_card/screen/routes.dart';

// ignore: camel_case_types
class adminpage extends StatefulWidget {
  const adminpage({super.key});

  @override
  State<adminpage> createState() => _adminpageState();
}

// ignore: camel_case_types
class _adminpageState extends State<adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 244, 247, 227),
      body: SingleChildScrollView(
        child: SafeArea(
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
                  height: 60,
                ),

                //ຄົ້ນຫາບັດນັກສືກສາ

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
                              'ຄົ້ນຫາບັດນັກສືກສາ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.search);
                            }),
                      ),
                    ),
                  ),
                ),

                //ເພີ່ມນັກສືກສາ

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
                              'ເພີ່ມນັກສືກສາ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.studentadd);
                            }),
                      ),
                    ),
                  ),
                ),
                // ແກ້ໄຂຂໍ້ມູນນັກສືກສາ

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
                              'ແກ້ໄຂຂໍ້ມູນນັກສືກສາ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.edit);
                            }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          backgroundColor:
                              const Color.fromARGB(192, 178, 177, 183)),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.login);
                      },
                      child: const Text(
                        "ອອກຈາກລະບົບ",
                        style: TextStyle(
                            color: Color.fromARGB(253, 255, 250, 250),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
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
}
