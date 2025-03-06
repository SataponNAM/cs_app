import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/crew_model.dart';

class CrewService {
  Future<CrewCollection> fetchCrewCollection ({required String strUrl}) async {
    try {
      final response = await http.get(
        Uri.parse(strUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json; charset=utf-8",
        },
      );
      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        // Create CourseCollection from the parsed JSON
        CrewCollection crewCollection =
            CrewCollection.fromJson(jsonResponse);

        return crewCollection;
      } else {
        throw Exception(
            'Failed to load crew: ${response.statusCode}');
      }
    } catch (e){
      debugPrint("Error fetching crew: $e");
      throw Exception("Error fetching crew: $e");
    }
  }
}
