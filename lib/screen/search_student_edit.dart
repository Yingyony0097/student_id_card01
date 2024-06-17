import 'package:flutter/material.dart';
import 'package:student_id_card/screen/class/cb01.dart';
import 'package:student_id_card/screen/class/cb02.dart';
import 'package:student_id_card/screen/class/cb03.dart';
import 'package:student_id_card/screen/class/ict01.dart';
import 'package:student_id_card/screen/class/ict02.dart';
import 'package:student_id_card/screen/class/ict03.dart';
import 'package:student_id_card/screen/class/ict04.dart';
import 'package:student_id_card/screen/class/it01.dart';
import 'package:student_id_card/screen/class/it02.dart';
import 'package:student_id_card/screen/class/it03.dart';
import 'package:student_id_card/screen/routes.dart';

class SearchEdit extends StatefulWidget {
  const SearchEdit({Key? key}) : super(key: key);

  @override
  State<SearchEdit> createState() => _SearchEditState();
}

class _SearchEditState extends State<SearchEdit> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 244, 247, 227),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 20),
              const Text(
                'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມມູນຂ່າວສານ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
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
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const SearchEdit ()));
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
              const SizedBox(height: 30),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const IT01 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 1',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                context, MaterialPageRoute(builder: (context) => const IT01 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 2',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                        Navigator.push(
                context, MaterialPageRoute(builder: (context) => const IT03()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 3',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const IT03 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ(IT) ປີທີ 4',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                        Navigator.push(
                context, MaterialPageRoute(builder: (context) => const IT03 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 1',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ICT01 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 2',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ICT02 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xC02702E2)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ວິສະວະກຳເຕັກໂນຊີການສື່ສານ(ICT) ປີທີ 3',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ICT03 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(
                            0xC02702E2), // หรือ Color.fromRGBO(192, 39, 2, 226)
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text(
                      'ວິສະວະກຳເຕັກໂນໂລຊີການສື່ສານ(ICT) ປີທີ 4',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ICT04 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(
                            0xC02702E2), // หรือ Color.fromRGBO(192, 39, 2, 226)
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                    ),
                    child: const Text(
                      'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 1',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const CB01 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(
                            0xC02702E2), // หรือ Color.fromRGBO(192, 39, 2, 226)
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text(
                      'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 2',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                    const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const CB02 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(
                            0xC02702E2), // หรือ Color.fromRGBO(192, 39, 2, 226)
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text(
                      'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 3',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                    const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                         Navigator.push(
                context, MaterialPageRoute(builder: (context) => const CB03 ()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(
                            0xC02702E2), // หรือ Color.fromRGBO(192, 39, 2, 226)
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text(
                      'ຄວາມປອດໄພທາງໄຊເບີ (CB) ປີທີ 4',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                    const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
