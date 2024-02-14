import 'package:flutter/material.dart';
import 'package:student_id_card/screen/admin_page.dart';

// ignore: camel_case_types
class studentEdit extends StatefulWidget {
  const studentEdit({super.key});

  @override
  State<studentEdit> createState() => _studentEditState();
}

// ignore: camel_case_types
class _studentEditState extends State<studentEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 254, 254),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'ກະລຸນາປ້ອນຂໍ້ມູນນັກສືກສາທີ່ຕ້ອງການເພີ່ມ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              const SizedBox(height: 15),
              const Text(
                'ລະຫັດນັກສືກສາ:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
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
                          hintText: 'ກະລຸນາປ້ອນລະຫັດນັກສືກສາ'),
                    ),
                  ),
                ),
              ),
              const Text(
                'ຊື່ພາສາລາວ:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
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
                          border: InputBorder.none, hintText: 'ກະລຸນາປ້ອນຊື່'),
                    ),
                  ),
                ),
              ),
              const Text(
                'ນາມສະກຸນພາສາລາວ:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
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
                          hintText: 'ກາລຸນາປ້ອນນາມສະກຸນ'),
                    ),
                  ),
                ),
              ),
              const Text(
                'ວັນ,ເດືອນ,ປີເກີດ:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
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
                          hintText: 'ກະລຸນາປ້ອນ ວັນ,ເດືອນ,ປີເກີດ'),
                    ),
                  ),
                ),
              ),
              const Text(
                'ວັນທີ່ອອກບັດ:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
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
                          hintText: 'ກະລຸນາປ້ອນວັນທີ່ອອກບັດນັກສືກສາ'),
                    ),
                  ),
                ),
              ),
              const Text(
                'ກຳນົດນຳໃຊ້ບັດ:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
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
                          hintText: 'ກຳນົດການນຳໃຊ້ບັດ'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'ອັບໂຫຼດຮູບບັດປະຈຳຕົວ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Text('3*4'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              //button

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                'ບັນທືກຂໍ້ມູນ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const adminpage();
                                    },
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),

                  //editbutton
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
