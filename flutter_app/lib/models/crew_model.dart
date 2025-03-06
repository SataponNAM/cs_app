import 'dart:convert';

CrewCollection crewCollectionFromJson(String str) => CrewCollection.fromJson(json.decode(str));

String crewCollectionToJson(CrewCollection data) => json.encode(data.toJson());

class Crew {
  final String name;
  final String englishName;
  final String image;
  final String email;
  final String phone;
  final String education;
  final String research;

  Crew({
    required this.name,
    required this.englishName,
    required this.image,
    required this.email,
    required this.phone,
    required this.education,
    required this.research,
  });

  factory Crew.fromJson(Map<String, dynamic> json) =>
  Crew(
        name: json["name"] ?? "name not found",
        englishName: json["english_name"] ?? "english name not found",
        image: json["image"] ?? "image not found",
        email: json["email"] ?? "email not found",
        phone: json["phone"] ?? "phone not found",
        education: json["education"] ?? "education not found",
        research: json["research"] ?? "research not found",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "english_name": englishName,
        "image": image,
        "email": email,
        "phone": phone,
        "education": education,
        "research": research,
      };
}

class CrewCollection {
  List<Crew> professor;
  List<Crew> executive;
  List<Crew> support;

  CrewCollection({
    required this.professor,
    required this.executive,
    required this.support,
  });

  factory CrewCollection.fromJson(Map<String, dynamic> json) => CrewCollection(
        professor: json["อาจารย์"] != null
            ? List<Crew>.from(json["อาจารย์"].map((x) => Crew.fromJson(x)))
            : [],
        executive: json["ผู้บริหารภาค"] != null
            ? List<Crew>.from(json["ผู้บริหารภาค"].map((x) => Crew.fromJson(x)))
            : [],
        support: json["บุคลากรสนับสนุน"] != null
            ? List<Crew>.from(
                json["บุคลากรสนับสนุน"].map((x) => Crew.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "อาจารย์": List<dynamic>.from(professor.map((x) => x.toJson())),
        "ผู้บริหารภาค": List<dynamic>.from(executive.map((x) => x.toJson())),
        "บุคลากรสนับสนุน": List<dynamic>.from(support.map((x) => x.toJson())),
      };
}