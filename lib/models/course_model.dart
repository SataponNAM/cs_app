import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  final String imageUrl;
  final String courseTitle;
  final String courseDescription;

  Course({
    required this.imageUrl,
    required this.courseTitle,
    required this.courseDescription,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        imageUrl: json["imageUrl"] ?? "No imageUrl",
        courseTitle: json["courseTitle"] ?? "No courseTitle available",
        courseDescription: json["courseDescription"] ?? "Unknown Date",
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "courseTitle": courseTitle,
        "courseDescription": courseDescription,
      };
}
