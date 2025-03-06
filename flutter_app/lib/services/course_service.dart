import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/course_model.dart';
import 'package:flutter_app/models/programs_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CourseHttp {

  // โหลดสาขา
  Future<List<Course>> fetchAllCourse({required String strUrl}) async {
    try {
      final response = await http.get(Uri.parse(strUrl), headers: {
        "Accept": "application/json",
        "content-type": "application/json; charset=utf-8", // เพิ่ม charset
      });

      if (response.statusCode == 200) {
        // ถอดรหัส UTF-8 อย่างชัดเจน
        final responseBody = utf8.decode(response.bodyBytes);
        List data = json.decode(responseBody);

        List<Course> courseList = data.map((e) {
          try {
            // สร้าง Course object โดยถอดรหัส UTF-8
            return Course(
              imageUrl: e['imageUrl'] ?? "",
              courseTitle: _decodeThaiText(e['courseTitle'] ?? ""),
              courseDescription: _decodeThaiText(e['courseDescription'] ?? ""),
            );
          } catch (error) {
            debugPrint('Error parsing course: $error');
            return Course(
              imageUrl: "",
              courseTitle: "ไม่พบชื่อหลักสูตร",
              courseDescription: "ไม่พบรายละเอียด",
            );
          }
        }).toList();

        return courseList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching course: $e');
      throw Exception('Error fetching course: $e');
    }
  }

  // โหลดหลักสูตร
  Future<CourseCollection> fetchCourseProgramCollection({required String strUrl}) async {
    try {
      final response = await http.get(
        Uri.parse(strUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json; charset=utf-8",
        },
      );

      if (response.statusCode == 200) {
        // Decode UTF-8 explicitly
        final responseBody = utf8.decode(response.bodyBytes);

        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        // Create CourseCollection from the parsed JSON
        CourseCollection courseCollection =
            CourseCollection.fromJson(jsonResponse);

        return courseCollection;
      } else {
        throw Exception(
            'Failed to load course programs: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching course programs: $e');
      throw Exception('Error fetching course programs: $e');
    }
  }

  // ฟังก์ชันช่วยถอดรหัสข้อความภาษาไทย
  String _decodeThaiText(String text) {
    try {
      return utf8.decode(text.codeUnits);
    } catch (e) {
      return text;
    }
  }
}
