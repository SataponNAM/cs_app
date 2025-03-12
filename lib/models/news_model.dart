import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  final String Title;
  final String Message;
  final String PostDate;
  final String type;
  final String img_url;

  News({
    required this.Title,
    required this.Message,
    required this.PostDate,
    required this.type,
    required this.img_url,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
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
