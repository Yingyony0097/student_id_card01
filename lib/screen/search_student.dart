import 'package:flutter/material.dart';

class Searchstudent extends StatefulWidget {
  const Searchstudent({super.key});

  @override
  State<Searchstudent> createState() => _SearchstudentState();
}

class _SearchstudentState extends State<Searchstudent> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 254, 254),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'ປ້ອນລະຫັດນັກສຶກສາ',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'ຄົ້ນຫາ',
                    style: TextStyle(fontSize: 20),
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

void main() {
  runApp(const MaterialApp(
    home: Searchstudent(),
  ));
}
