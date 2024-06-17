import 'package:flutter/material.dart';
import 'package:student_id_card/screen/class/cb01.dart';
import 'package:student_id_card/screen/class/cb02.dart';
import 'package:student_id_card/screen/class/cb03.dart';
import 'package:student_id_card/screen/class/cb04.dart';
import 'package:student_id_card/screen/class/ict01.dart';
import 'package:student_id_card/screen/class/ict02.dart';
import 'package:student_id_card/screen/class/ict03.dart';
import 'package:student_id_card/screen/class/ict04.dart';
import 'package:student_id_card/screen/class/it01.dart';
import 'package:student_id_card/screen/class/it02.dart';
import 'package:student_id_card/screen/class/it03.dart';
import 'package:student_id_card/screen/class/it04.dart';
import 'package:student_id_card/screen/routes.dart';
import 'package:student_id_card/screen/search_page.dart';

// ignore: camel_case_types
class SearchEdit extends StatefulWidget {
  const SearchEdit({Key? key}) : super(key: key);

  @override
  State<SearchEdit> createState() => _SearchEditState();
}

Widget _buildButton(String text, VoidCallback onPressed,
    {double? width, EdgeInsets? padding}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Padding(
      padding: padding ?? const EdgeInsets.all(20.0),
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(192, 39, 2, 226),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ),
      ),
    ),
  );
}
Widget _addbuildButton(
  String text,
  VoidCallback onPressed,
  String className,
  String academicYear,
  {double? width, EdgeInsets? padding}
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Padding(
      padding: padding ?? const EdgeInsets.all(20.0),
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(192, 39, 2, 226),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}


class _SearchEditState extends State<SearchEdit> {
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
                    onPressed: () async {
                      final searchQuery = SearchController().text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(searchQuery: searchQuery),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(192, 39, 2, 226),
                      ),
                      minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: const Text(
                      'ຄົ້ນຫາ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            _buildButton(
              'ເຕັກໂນໂລຊີຂໍ້ມູນຂ່າວສານ(IT) ປີທີ1',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IT01()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
            
            _buildButton(
              'ເຕັກໂນໂລຊີຂໍ້ມູນຂ່າວສານ(IT) ປີທີ2',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IT02()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ເຕັກໂນໂລຊີຂໍ້ມູນຂ່າວສານ(IT) ປີທີ3',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IT03()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ເຕັກໂນໂລຊີຂໍ້ມູນຂ່າວສານ(IT) ປີທີ4',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IT04()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ເຕັກໂນໂລຊີການສື່ສານ(ICT) ປີທີ1',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ICT01()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ເຕັກໂນໂລຊີການສື່ສານ(ICT) ປີທີ2',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ICT02()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ເຕັກໂນໂລຊີການສື່ສານ(ICT) ປີທີ3',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ICT03()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ເຕັກໂນໂລຊີການສື່ສານ(ICT) ປີທີ4',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ICT04()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ຄວາມປອດໄພທາງໄຊເບີ(CB) ປີທີ1',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CB01()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ຄວາມປອດໄພທາງໄຊເບີ(CB) ປີທີ2',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CB02()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ຄວາມປອດໄພທາງໄຊເບີ(CB) ປີທີ3',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CB03()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
              _buildButton(
              'ຄວາມປອດໄພທາງໄຊເບີ(CB) ປີທີ4',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CB04()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
            _buildButton(
              'ເພີ່ມຫ້ອງຮຽນ',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IT02()),
                );
              },
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15.0), // ปรับ padding ในแนวดิ่งเพื่อปรับตำแหน่งข้อความ
            ),
             
          ],
        ),
      )),
    );
  }
}
