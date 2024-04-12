import 'dart:convert';
import 'package:http/http.dart' as http;
import '../DataModels/Manager.dart';



class ManagerService {
  static const String apiUrl =
      'https://b5mkgbw0-8000.inc1.devtunnels.ms/getManagers?role_id=rol_qLO42FIvSNsdZEO4';

  static Future<List<Manager>> fetchManagers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          return jsonData.map((managerJson) => Manager.fromJson(managerJson)).toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}