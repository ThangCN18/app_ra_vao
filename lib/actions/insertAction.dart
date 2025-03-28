// import 'package:http/http.dart' as http;
//
// class InsertAction {
//   static const String baseUrl = 'https://10.0.2.2:7269/api';
//
//   // static Future<List<PhanXuong>> getPhanXuong(String token) async {
//   static Future<void> getPhanXuong(String token) async {
//
//     try {
//       var response = await http.get(
//         Uri.parse('$baseUrl/tuankiemngay/getphanxuong'),
//         headers: {'Content-Type': 'application/json', 'Authorization': token},
//       );
//
//       if (response.statusCode == 200) {
//         dynamic responseData = json.decode(response.body);
//
//         if (responseData is List) {
//           responseData.forEach((item) {
//             if (item is Map<String, dynamic>) {
//               PhanXuong newPhanXuong = PhanXuong(
//                 id: int.parse(item['id'].toString()),a
//                 maPX: item['maPX'],
//                 tenPX: item['tenPX'],
//                 trangThai: item['trangThai'],
//               );
//               phanxuongs.add(newPhanXuong);
//             }
//           });
//           print(phanxuongs[0].tenPX);
//           return phanxuongs;
//         } else {
//           print('Response data is not a List');
//           return phanxuongs;
//         }
//       } else {
//         Map<String, dynamic> responseData = json.decode(response.body);
//         String message = responseData['message'].toString();
//         return phanxuongs;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return phanxuongs;
//     }
//   }
//
// }
