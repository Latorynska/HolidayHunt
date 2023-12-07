import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wisata_app/models/user.dart';

const String endpointlogin = "https://65713f8409586eff6642581b.mockapi.io/user";

class AuthService {
  Future<UserModel> login(String email, String password) async {
    try {
      // Send a request to the mock API endpoint
      final response = await http.get(Uri.parse(endpointlogin));
      if (response.statusCode == 200) {
        final List<dynamic> usersData = json.decode(response.body);

        // Check if there is a user with the provided email and password
        final user = usersData.firstWhere(
          (userData) =>
              userData['email'] == email && userData['password'] == password,
          orElse: () => null,
        );

        if (user != null) {
          return UserModel(
              email: user['email'],
              password: user['password'],
              username: user['username'],
              telp: user['telp'],
              imageUrl: user['imageUrl']);
        } else {
          return UserModel(email: '', password: '');
        }
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      print(e);
      throw Exception('Login failed');
    }
  }
}
