class Student {
  final String images;
  final String sdCardID;
  final String fname_la;
  final String lname_la;
  final String fname_en;
  final String lname_en;
  final String date_of_birth;
  final String date_start;
  final String date_end;

  Student({
    required this.images,
    required this.sdCardID,
    required this.fname_la,
    required this.lname_la,
    required this.fname_en,
    required this.lname_en,
    required this.date_of_birth,
    required this.date_start,
    required this.date_end,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      images: json['images'] ?? '',
      sdCardID: json['sdCardID'] ?? '',
      fname_la: json['fname_la'] ?? '',
      lname_la: json['lname_la'] ?? '',
      fname_en: json['fname_en'] ?? '',
      lname_en: json['lname_en'] ?? '',
      date_of_birth: json['date_of_birth'] ?? '',
      date_start: json['date_start'] ?? '',
      date_end: json['date_end'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'images': images,
      'sdCardID': sdCardID,
      'fname_la': fname_la,
      'lname_la': lname_la,
      'fname_en': fname_en,
      'lname_en': lname_en,
      'date_of_birth': date_of_birth,
      'date_start': date_start,
      'date_end': date_end,
    };
  }
}
