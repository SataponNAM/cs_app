import 'dart:convert';

class CourseProgram {
  final String category;
  final String title;
  final List<CourseLink> links;

  CourseProgram({
    required this.category,
    required this.title,
    required this.links,
  });

  factory CourseProgram.fromJson(Map<String, dynamic> json) => CourseProgram(
        category: json["category"] ?? "",
        title: json["title"] ?? "",
        links: json["links"] != null
            ? List<CourseLink>.from(
                json["links"].map((x) => CourseLink.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "title": title,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class CourseLink {
  final String name;
  final String url;

  CourseLink({
    required this.name,
    required this.url,
  });

  factory CourseLink.fromJson(Map<String, dynamic> json) => CourseLink(
        name: json["name"] ?? "Unnamed Link",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class CourseCollection {
  final List<CourseProgram> courses;

  CourseCollection({
    required this.courses,
  });

  factory CourseCollection.fromJson(Map<String, dynamic> json) => 
    CourseCollection(
      courses: json["courses"] != null
          ? List<CourseProgram>.from(
              json["courses"].map((x) => CourseProgram.fromJson(x)))
          : [],
    );

  Map<String, dynamic> toJson() => {
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}

// Helper functions for parsing
CourseCollection courseCollectionFromJson(String str) => 
    CourseCollection.fromJson(json.decode(str));

String courseCollectionToJson(CourseCollection data) => 
    json.encode(data.toJson());