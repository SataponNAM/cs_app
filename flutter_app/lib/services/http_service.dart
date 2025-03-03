// http

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/news_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HttpService {
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

        return data.map((e) {
          try {
            return News.fromJson(e);
          } catch (error) {
            debugPrint('Error parsing News item: $error');
            return News(
              Title: "No Title",
              Message: "No message available",
              PostDate: "Unknown Date",
              type: "Uncategorized",
              img_url: "",
            );
          }
        }).toList();
      } else {
        debugPrint('Failed loading data!');
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      debugPrint('Error fetching news: $e');
      throw Exception('Error fetching news: $e');
    }
  }

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
