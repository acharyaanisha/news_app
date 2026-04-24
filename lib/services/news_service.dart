import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news.dart';

class NewsService {
  static const String _apiKey = 'pub_48b058dfa014468187463f5e697fa782';
  static const String _baseUrl = 'https://newsdata.io/api/1/latest';

  // Fetch all news
  Future<List<News>> fetchAllNews() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl?apikey=$_apiKey&q=all'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['results'] as List<dynamic>? ?? [];
        return articles
            .map((article) => News.fromJson(article as Map<String, dynamic>))
            .where(
              (news) => news.imageUrl.isNotEmpty,
            ) // Filter out news without images
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  // Fetch news by category
  Future<List<News>> fetchNewsByCategory(String category) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl?apikey=$_apiKey&q=$category'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['results'] as List<dynamic>? ?? [];
        return articles
            .map((article) => News.fromJson(article as Map<String, dynamic>))
            .where((news) => news.imageUrl.isNotEmpty)
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news by category: $e');
    }
  }

  // Search news by query
  Future<List<News>> searchNews(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      final response = await http
          .get(Uri.parse('$_baseUrl?apikey=$_apiKey&q=$query'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['results'] as List<dynamic>? ?? [];
        return articles
            .map((article) => News.fromJson(article as Map<String, dynamic>))
            .where((news) => news.imageUrl.isNotEmpty)
            .toList();
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching news: $e');
    }
  }

  // Fetch news by multiple categories
  Future<List<News>> fetchNewsByMultipleCategories(
    List<String> categories,
  ) async {
    try {
      final query = categories.join(' OR ');
      final response = await http
          .get(Uri.parse('$_baseUrl?apikey=$_apiKey&q=$query'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['results'] as List<dynamic>? ?? [];
        return articles
            .map((article) => News.fromJson(article as Map<String, dynamic>))
            .where((news) => news.imageUrl.isNotEmpty)
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
