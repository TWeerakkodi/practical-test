import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<String>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
