// http
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/news_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsService {
  
  // ดึงข้อมูลข่าว
  Future<List<News>> fetchNews({required String strUrl}) async {
    debugPrint('url: $strUrl');
    try {
      final response = await http.get(Uri.parse(strUrl), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        debugPrint('Response Body: ${response.body}');

        List<News> newsList = data.map((e) {
          try {
            return News.fromJson(e);
          } catch (error) {
            debugPrint('Error parsing News item: $error');
            return News(
              Title: "No Title",
              Message: "No message available",
              PostDate: "01/01/1970", // ใช้วันที่เริ่มต้นแทน Unknown Date
              type: "Uncategorized",
              img_url: "",
            );
          }
        }).toList();

        // เรียงลำดับจากใหม่ -> เก่า (ล่าสุดมาก่อน)
        final DateFormat formatter = DateFormat("dd/MM/yyyy");
        newsList.sort((a, b) {
          DateTime dateA;
          DateTime dateB;
          try {
            dateA = formatter.parse(a.PostDate);
          } catch (e) {
            dateA = DateTime(1970); // ถ้าแปลงไม่ได้ ใช้ค่าเริ่มต้น
          }
          try {
            dateB = formatter.parse(b.PostDate);
          } catch (e) {
            dateB = DateTime(1970);
          }
          return dateB.compareTo(dateA); // เรียงจากใหม่ไปเก่า
        });

        return newsList;
      } else {
        debugPrint('Failed loading data!');
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      debugPrint('Error fetching news: $e');
      throw Exception('Error fetching news: $e');
    }
  }

  // โหลด Image Url
  Future<List<String>> fetchImageList(String baseUrl) async {
    if (baseUrl.isEmpty) return []; // ถ้าไม่มี URL, ไม่ต้องโหลดอะไรเลย

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        List<String> fileNames = [];

        document.querySelectorAll('a').forEach((element) {
          String? href = element.attributes['href'];

          if (href != null && RegExp(r'\.(png|jpg|jpeg)$').hasMatch(href)) {
            fileNames.add(href);
          }
        });

        return fileNames.isNotEmpty
            ? fileNames
            : []; // ไม่มีรูปให้คืนค่าเป็น `''`
      } else {
        print('Error: HTTP ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching image list: $e');
      return [];
    }
  }
}
