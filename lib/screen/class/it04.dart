import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IT04 extends StatefulWidget {
  const IT04({Key? key}) : super(key: key);

  @override
  _IT04State createState() => _IT04State();
}

class _IT04State extends State<IT04> {
  late Future<List<Student>> futureStudents;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  Future<List<Student>> fetchStudents() async {
    try {
      // Get token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // Create Dio instance with token in header
      Dio dio = Dio(BaseOptions(headers: {'Authorization': 'Bearer $token'}));

      // Send request to API endpoint with Dio instance
      final response = await dio.get('http://192.168.0.193:8000/student/studentsyear?field_of_study=IT&year=3');

      if (response.statusCode == 200) {
        List<Student> students = (response.data as List).map((item) => Student.fromJson(item)).toList();
        return students;
      } else {
        throw Exception('Failed to load students');
      }
    } catch (error) {
      throw Exception('Failed to load students: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ສະຖາບັນເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ"),
        backgroundColor: Colors.blue, 
      ),
      body: FutureBuilder<List<Student>>(
        future: futureStudents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                  final double imageWidth = 100; 
                final double imageHeight = 100; 

                return ListTile(
                  leading: Image.network(
                    snapshot.data![index].images,
                    width: imageWidth, 
                    height: imageHeight, 
                  ),
                  title: Text(snapshot.data![index].fnameLa +
                      ' ' +
                      snapshot.data![index].lnameLa),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Student {
  final String fnameLa;
  final String lnameLa;
  final String images;

  Student({
    required this.fnameLa,
    required this.lnameLa,
    required this.images,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      fnameLa: json['fname_la'],
      lnameLa: json['lname_la'],
      images: json['images'],
    );
  }
}