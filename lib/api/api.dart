import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siya/data/modeldata.dart';

// API Service
class ApiService {
  static const String baseUrl = "https://hacker-news.firebaseio.com/v0";

  static Future<List<int>> fetchTopStories() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/topstories.json?print=pretty"));
      if (response.statusCode == 200) {
        return List<int>.from(json.decode(response.body));
      } else {
        throw HttpException(response.statusCode, "Failed to load top stories");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  static Future<Story> fetchStory(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/item/$id.json?print=pretty"));
      if (response.statusCode == 200) {
        return Story.fromJson(json.decode(response.body));
      } else {
        throw HttpException(response.statusCode, "Failed to load story");
      }
    } catch (e) {
      throw Exception("Error fetching story: ${e.toString()}");
    }
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;
  HttpException(this.statusCode, this.message);

  @override
  String toString() {
    return "HTTP $statusCode: $message";
  }
}