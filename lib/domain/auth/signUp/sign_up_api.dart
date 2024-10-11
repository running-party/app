import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sign_up_model.dart';

class SignUpApi {
  static const String apiUrl = 'https://yourapi.com/auth/signup';

  static Future<bool> signUp(SignUpModel model) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
