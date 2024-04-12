import 'dart:convert';
import 'package:http/http.dart' as http;

import '../DataModels/project.dart';


class ProjectService {
  static const String apiUrl =
      'https://b5mkgbw0-8000.inc1.devtunnels.ms/projects?role=Admin&id=auth0|1e316bf2-3572-4dd9-a627-0e779648c30e';

  static Future<List<Projects>> fetchProjects() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return (jsonData['data'] as List)
            .map((projectJson) => Projects.fromJson(projectJson))
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}