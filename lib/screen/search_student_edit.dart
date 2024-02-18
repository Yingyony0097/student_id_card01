import 'package:flutter/material.dart';
import 'package:student_id_card/screen/routes.dart';
// ignore: camel_case_types
class searchEdit extends StatefulWidget {
  const searchEdit({super.key});

  @override
  State<searchEdit> createState() => _searchEditState();
}

// ignore: camel_case_types
class _searchEditState extends State<searchEdit> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(244, 244, 247, 227),
      
      body: SingleChildScrollView(
        child:Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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


                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: SearchController(),
                      decoration: const InputDecoration(
                        labelText: 'ປ້ອນລະຫັດນັກສຶກສາທີ່ຕ້ອງການແກ້ໄຂ',
                        labelStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.showCard);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(192, 39, 2, 226)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    
                    child: const Text(
                      'ຄົ້ນຫາ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: 20,),


                // ປຸ່ມປີ1

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
                              'ນັກສືກສາປີທີ 1',
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
                // ປຸ່ມປີ2

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
                              'ນັກສືກສາປີທີ 2',
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
                // ປຸ່ມປີ3

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
                              'ນັກສືກສາປີທີ 3',
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
                // ປຸ່ມປີ4

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
                              'ນັກສືກສາປີທີ 4',
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
            ],
          ),
        ) ),
    );
  }
}