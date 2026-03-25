import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{
  static const base = 'https://rickandmortyapi.com/api/character';
  static Future<Map<String, dynamic>> fetchPage(int page, {String? query, String? status, String? species}) async {
    final params = <String, String>{'page': '$page'};
    if (query != null && query.isNotEmpty) params['name'] = query;
    if (status != null && status.isNotEmpty) params['status'] = status;
    if (species != null && species.isNotEmpty) params['species'] = species;
    final uri = Uri.parse(base).replace(queryParameters: params);
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('API error: ${res.statusCode}');
    return json.decode(res.body) as Map<String, dynamic>;
  }
    static Future<Map<String, dynamic>> fetchById(int id) async {
    final uri = Uri.parse('$base/$id');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('API error: ${res.statusCode}');
    return json.decode(res.body) as Map<String, dynamic>;
  }
}