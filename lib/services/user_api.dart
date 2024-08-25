import 'package:untitled/model/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class UserApi {

  static Future<List<User>> fetchUsers() async {
    const url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;

    final users = results.map((e) {
     return User.fromMap(e);
    }).toList();

    return users;
  }
}