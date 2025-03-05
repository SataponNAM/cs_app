import 'dart:convert';

Course productFromJson(String str) => Course.fromJson(json.decode(str));

String productToJson(Course data) => json.encode(data.toJson());

class Course {
  final String Title;
  final String Message;
  final String PostDate;
  final String type;
  final String img_url;

  Course({
    required this.Title,
    required this.Message,
    required this.PostDate,
    required this.type,
    required this.img_url,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        Title: json["Title"] ?? "No Title",
        Message: json["Message"] ?? "No message available",
        PostDate: json["PostDate"] ?? "Unknown Date",
        type: json["type"] ?? "Uncategorized",
        img_url: json["img_url"] ?? "", // Provide a default value
      );

  Map<String, dynamic> toJson() => {
        "Title": Title,
        "Message": Message,
        "PostDate": PostDate,
        "type": type,
        "img_url": img_url,
      };
}
