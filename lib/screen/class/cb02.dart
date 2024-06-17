import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_id_card/screen/student_edit.dart';

class CB02 extends StatefulWidget {
  const CB02({Key? key}) : super(key: key);

  @override
  _CB02State createState() => _CB02State();
}

class _CB02State extends State<CB02> {
  late Future<List<Student>> futureStudents = Future.value([]);
  late String token;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      token = prefs.getString('token') ?? '';
      // Use Future.delayed() to wait for the initial value of futureStudents
      Future.delayed(Duration.zero, () {
        setState(() {
          futureStudents = fetchStudents('CB', '2', token);
        });
      });
    });
  }

  Future<List<Student>> fetchStudents(String fieldOfStudy, String year, String token) async {
    try {
      Dio dio = Dio(BaseOptions(headers: {'Authorization': 'Bearer $token'}));
      final response = await dio.get('http://192.168.43.127:8000/student/studentsyear?field_of_study=$fieldOfStudy&year=$year');

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

  Future<void> deleteStudent(int id) async {
    try {
      Dio dio = Dio(BaseOptions(headers: {'Authorization': 'Bearer $token'}));
      await dio.delete('http://192.168.43.127:8000/student/$id');
      // After deleting, reload the students list
      setState(() {
        futureStudents = fetchStudents('CB', '2', token);
      });
    } catch (error) {
      throw Exception('Failed to delete student: $error');
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                const double imageWidth = 100;
                const double imageHeight = 100;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: Image.network(
                      snapshot.data![index].images,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                    title: Text(
                        '${snapshot.data![index].fnameLa} ${snapshot.data![index].lnameLa}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentEdit(),
                              ),
                            ).then((value) {
                              // After returning from StudentEdit page, reload the data
                              setState(() {
                                futureStudents = fetchStudents('CB', '2', token);
                              });
                            });
                          },
                          child: const Text(
                            'ແກ້ໄຂ',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Call the deleteStudent function when the delete button is pressed
                            deleteStudent(snapshot.data![index].id);
                          },
                          child: const Text(
                            'ລົບ',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
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
  final int id;
  final String fnameLa;
  final String lnameLa;
  final String images;

  Student({
    required this.id,
    required this.fnameLa,
    required this.lnameLa,
    required this.images,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      fnameLa: json['fname_la'] as String,
      lnameLa: json['lname_la'] as String,
      images: json['images'] as String,
    );
  }
}
