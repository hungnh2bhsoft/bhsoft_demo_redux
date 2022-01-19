import 'dart:convert';

import 'package:http/http.dart';

import 'search_result.dart';

class GithubSearch {
  final String _baseUrl = 'https://api.github.com/search/repositories';

  Future<SearchResult> searchRepositories(String query) async {
    final response = await get(Uri.parse('$_baseUrl?q=$query'));
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return SearchResult.fromJson(data);
  }
}

class GithubSearchException implements Exception {}
