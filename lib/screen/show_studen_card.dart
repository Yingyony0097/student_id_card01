import 'package:flutter/material.dart';

class ShowCard extends StatefulWidget {
  const ShowCard({super.key});

  @override
  State<ShowCard> createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 57, 76, 255),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 18),
                const Text(
                  'ສະຖາບັນ ເຕັກໂນໂລຊີ ການສື່ສານຂໍ້ມມູນຂ່າວສານ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Institute of Infomation and Communications Technology',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 18),
                const Text(
                  "ບັດນັກສືກສາ ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/images/avatar.jpg'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'ນາງ ອໍລະພິນ ພັນພະສີ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ms Orlaphin phanpasy',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 18),

                //ລະຫັດນັກສືກສາ
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Text(
                        'ລະຫັດນັກສືກສາ:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        'IICTIT3907520',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                //date of brath
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Text(
                        'ວັນ,ດືອນ,ປີເກີດ:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        '27 ຕຸລາ 2001',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 18),


                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Text(
                        'ວັນທີ່ອອກບັດ:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        '01 ຕຸລາ 2023',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 18),



                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Text(
                        'ກຳນົດນຳໃຊ້ບັດ:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        '20 ຕຸລາ 2025',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )
                    ],
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
