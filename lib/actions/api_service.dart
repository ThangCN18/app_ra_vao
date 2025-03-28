// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ApiService {
//   static const String baseUrl = 'https://example.com/api';
//
//   static Future<Map<String, dynamic>> login(String username, String password) async {
//     final String loginUrl = '$baseUrl/login';
//
//     try {
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         body: {
//           'username': username,
//           'password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         return {'success': true, 'data': responseData};
//       } else {
//         return {'success': false, 'error': 'Failed to log in'};
//       }
//     } catch (e) {
//
//       print('Error: $e');
//       return {'success': false, 'error': 'An error occurred'};
//     }
//   }
// }

