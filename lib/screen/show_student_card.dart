import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowStudentScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;

  ShowStudentScreen({Key? key, required this.studentData}) : super(key: key);

  String formatLaoDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formattedDate = formatter.format(date);

    final Map<String, String> laoMonths = {
      'January': 'ມັງກອນ',
      'February': 'ກຸມພາ',
      'March': 'ມີນາ',
      'April': 'ເມສາ',
      'May': 'ພຶດສະພາ',
      'June': 'ມິຖຸນາ',
      'July': 'ກໍລະກົດ',
      'August': 'ສິງຫາ',
      'September': 'ກັນຍາ',
      'October': 'ຕຸລາ',
      'November': 'ພະຈິກ',
      'December': 'ທັນວາ'
    };

    String laoFormattedDate = formattedDate;
    laoMonths.forEach((key, value) {
      laoFormattedDate = laoFormattedDate.replaceAll(key, value);
    });

    return laoFormattedDate;
  }

  String getGenderTitle(String gender) {
    if (gender == 'Male') {
      return 'ທ';
    } else if (gender == 'Female') {
      return 'ນ';
    } else {
      return '';
    }
  }

  String getGenderTitles(String gender) {
    if (gender == 'Male') {
      return 'Mr';
    } else if (gender == 'Female') {
      return 'Ms';
    } else {
      return '';
    }
  }

  Future<void> _restoreOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Set the orientation to landscape when entering this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return WillPopScope(
      onWillPop: () async {
        await _restoreOrientation();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF002324),
                        const Color(0xFF00D4FF),
                        Color(0xFF2739ED),
                        Color(0xFF2739ED),
                        Color(0xFF2739ED).withOpacity(0.17),
                      ],
                      stops: [0, 0, 0.56, 1, 1],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 2.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 90,
                          height: 90,
                        ),
                        const SizedBox(width: 30),
                        Flexible(
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: const Text(
                                  'ສະຖາບັນເຕັກໂນໂລຊີການສື່ສານຂໍ້ມູນຂ່າວສານ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: const Text(
                                  'Institute of Information and Communication Technology',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: const Text(
                        'ບັດປະຈຳຕົວນັກສຶກສາ',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: studentData['images'] != null && studentData['images'].isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: studentData['images'].startsWith('http')
                                      ? studentData['images']
                                      : 'http://192.168.205.62:8000/uploads/' + studentData['images'],
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${getGenderTitle(studentData['gender'])}. ${studentData['fname_la']} ${studentData['lname_la']}',
                                  style: const TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${getGenderTitles(studentData['gender'])}. ${studentData['fname_en']} ${studentData['lname_en']}',
                                  style: const TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'ລະຫັດບັດນັກສຶກສາ: ${(studentData['sdCardID'])}',
                                  style: const TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'ວັນເດືອນປີເກີດ: ${formatLaoDate(DateTime.parse(studentData['date_of_birth']))}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'ວັນທີອອກບັດ: ${formatLaoDate(DateTime.parse(studentData['date_start']))}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'ກຳນົດນຳໃຊ້ບັດ: ${formatLaoDate(DateTime.parse(studentData['date_end']))}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/F-Darf.png',
                                        width: 300,
                                        height: 103,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
