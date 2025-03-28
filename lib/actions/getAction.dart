import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/actions/localStory.dart';
import 'package:ra_soat_ra_vao/configs/toast_message.dart';
import 'package:ra_soat_ra_vao/models/ChuyenHangModel.dart';
import 'package:ra_soat_ra_vao/models/CreateHieuChinhModel.dart';
import 'package:ra_soat_ra_vao/models/CreateTuanKiemModel.dart';
import 'package:ra_soat_ra_vao/models/CreateXacNhanModel.dart';
import 'package:ra_soat_ra_vao/models/DiaDiemModel.dart';
import 'package:ra_soat_ra_vao/models/HieuChinhModel.dart';
import 'package:ra_soat_ra_vao/models/KeHoachModel.dart';
import 'package:ra_soat_ra_vao/models/KeHoachTuanKiem.dart';
import 'package:ra_soat_ra_vao/models/LichSuRaVaoModel.dart';
import 'package:ra_soat_ra_vao/models/NoiDungHieuChinhModel.dart';
import 'package:ra_soat_ra_vao/screens/XacNhanModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GetAction {

  static Future<List<KeHoachTuanKiem>> getKeHoach(String token) async {

    try {
      List<KeHoachTuanKiem> datas = [];
      var formattedDate = DateTime.now().toString().substring(0,7);
      String baseUrl2 = await LocalStory.getData();
      var response = await http.get(
        Uri.parse('$baseUrl2/KeHoach/get?start=$formattedDate-01&end=$formattedDate-28'),
        // Uri.parse('$baseUrl2/KeHoach/get?start=2024-01-01&end=2024-12-28'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " +token},
      );
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        responseData['data'].forEach((item) {
          print(item['id']);
          if (item is Map<String, dynamic>) {
            KeHoachTuanKiem newDataKBTModel = KeHoachTuanKiem(
                id: item['id']??0,
              phanXuong: item["diaDiem"]["parent"] == null?"":item["diaDiem"]["parent"]["tenDiaDiem"],
              trangThai: item['trangThai']==-1?3:item['trangThai']??0,
              boPhan: item["diaDiem"]["parent"] == null?"":item["diaDiem"]["parent"]["parent"] == null?"": item["diaDiem"]["parent"]["parent"]["maDiaDiem"],
              soLanDo: item['soLan']??1,
              tenPhong: item["diaDiem"]["tenDiaDiem"]??"",
              thang: item["thang"].toString().substring(0,7),
              mucDo: item["mucDo"]


            );
            datas.add(newDataKBTModel);

          }
        });
        return datas;
      } else {

        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<DiaDiemModel>> getDiaDiem(String token, int cap) async {

    try {
      List<DiaDiemModel> datas = [];
      var formattedDate = DateTime.now().toString().substring(0,7);
      String baseUrl2 = await LocalStory.getData();
      String urlNew = '';
      if(cap == 1){
        urlNew = '$baseUrl2/DiaDiem/get?cap=1';
      }else{
        urlNew = '$baseUrl2/DiaDiem/get-child?idparent=$cap';
      }

      var response = await http.get(
        Uri.parse(urlNew),
        // Uri.parse('$baseUrl2/KeHoach/get?start=2024-10-01&end=2024-10-28'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " +token},
      );
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        responseData['data'].forEach((item) {
          if (item is Map<String, dynamic>) {
            DiaDiemModel newDiaDiem = DiaDiemModel(
                id: item['id']??0,
                maDiaDiem: item["maDiaDiem"]??"",
                tenDiaDiem: item["tenDiaDiem"]??"",
                cap: item['cap']??0,
                idParent: item['idParent']??0,
                trangThai: item['trangThai']??0,
               );
            datas.add(newDiaDiem);
          }
        });
        return datas;
      } else {

        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // static Future<void> CreateTuanKiemAction(BuildContext context,String token, CreateTuanKiemModel _body, Function setLoadding) async {
  //
  //   try {
  //
  //     String baseUrl2 = await LocalStory.getData();
  //     var response = await http.post(
  //       Uri.parse('$baseUrl2/TuanKiem/create'),
  //       body: _body,
  //       headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " +token},
  //     );
  //     if (response.statusCode == 200) {
  //       dynamic responseData = json.decode(response.body);
  //       if(responseData['data']['status']== "error"){
  //         ToastMessage.showMessageError(context, "Đã có lỗi xảy ra");
  //         setLoadding();
  //       }else{
  //         ToastMessage.showMessageSuccess(context, "Cập nhật thành công");
  //         setLoadding();
  //       }
  //
  //
  //     } else {
  //       ToastMessage.showMessageError(context, "Cập nhật không thành công");
  //       setLoadding();
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     ToastMessage.showMessageError(context, "Cập nhật không thành công");
  //     setLoadding();
  //   }
  // }

  static Future<void> CreateTuanKiemAction(
      BuildContext context,
      String token,
      CreateTuanKiemModel _body,
      Function setLoadding) async {


    try {
      String baseUrl2 = await LocalStory.getData();
      var url = Uri.parse('$baseUrl2/TuanKiem/create');
      var requestBody = json.encode(_body.toJson());
      var response = await http.post(
        url,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token
        },
      );

      // Handle the response based on the status code
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

          // Display a success message
          ToastMessage.showMessageSuccess(context, "Cập nhật thành công");
        setLoadding();

      } else {
        // If the status code is not 200, show an error message
        ToastMessage.showMessageError(context, "Cập nhật không thành công");
        setLoadding();
      }
    } catch (e) {
      print('Error: $e');
      ToastMessage.showMessageError(context, "Cập nhật không thành công");
      setLoadding();
    }
  }

  static Future<List<ChuyenHangModel>> getChuyenHang(String token, String start, String end) async {
    try {
      print("sâsa");
      List<ChuyenHangModel> datas = [];
      // Subtract one day from the current date and format it
      // var formattedDate = DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);
      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(
        // Uri.parse('$baseUrl2/chuyenhangnew/GetByDateRangeXacNhan?startDate=$formattedDate&endDate=$formattedDate 23:59'),
        Uri.parse('$baseUrl2/chuyenhangnew/GetByDateRangeXacNhan?startDate=$start&endDate=$end 23:59'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            ChuyenHangModel newDataKBTModel = ChuyenHangModel(
                // id: item['id'] ?? 0,  // Ensure `id` is converted to String
                // stt: (datas.length + 1),  // Ensure `stt` is converted to String
                // bienSoXe: item['bienSoXe'] ?? "",
                // congRaVao: item['congRaVao'] ?? "",
                // ghiChu: item['ghiChu'] ?? "",
                // hoTenLaiXe: item['hoTenLaiXe'] ?? "",
                // idKeHoach: item['idKeHoach'] ?? "",
                // maNhanVienCapThe: item['maNhanVienCapThe'] ?? "",
                // maNhanVienThuHoiThe: item['maNhanVienThuHoiThe'] ?? "",
                // nhanVienCapThe: item['nhanVienCapThe'] ?? "",
                // nhanVienThuHoiThe: item['nhanVienThuHoiThe'] ?? "",
                // soCccdLaiXe: item['soCccdLaiXe'] ?? "",
                // soDienThoaiLaiXe: item['soDienThoaiLaiXe'] ?? "",
                // soThe: item['soDienThoaiLaiXe'] ?? "Không",
                // thoiGianCapThe: item['thoiGianCapThe'] != null ? item['thoiGianCapThe'].substring(0, 16) : "",
                // thoiGianDuKien: item['thoiGianDuKien'] != null ? item['thoiGianDuKien'].substring(0, 10) : "",
                // thoiGianThuHoiThe: item['thoiGianThuHoiThe'] != null ? item['thoiGianThuHoiThe'].substring(0, 16) : "",
                // trangThaiThe: "oke"
              // This is a placeholder; modify as needed
                id: item['id'] ?? 0,  // Ensure `id` is converted to String
                stt: (datas.length + 1),  // Ensure `stt` is converted to String
                bienSoXe: item['bienSoXe'] ?? "",
                congRaVao: item['congRaVao'] ?? "",
                ghiChu: item['ghiChu'] ?? "",
                hoTenLaiXe: item['hoTenLaiXe'] ?? "",
                idKeHoach: item['idKeHoach'] ?? "",
                maNhanVienCapThe: item['maNhanVienCapThe'] ?? "",
                maNhanVienThuHoiThe: item['maNhanVienThuHoiThe'] ?? "",
                nhanVienCapThe: item['nhanVienCapThe'] ?? 0,
                nhanVienThuHoiThe: item['nhanVienThuHoiThe'] ?? 0,
                soCccdLaiXe: item['soCccdLaiXe'] ?? "",
                soDienThoaiLaiXe: item['soDienThoaiLaiXe'] ?? "",
                soThe: item['soThe'] ?? "Không",
                thoiGianCapThe: item['thoiGianCapThe'] != null ? item['thoiGianCapThe'].substring(0, 10)+ " " + item['thoiGianCapThe'].substring(11, 16) : "",
                thoiGianDuKien: item['thoiGianDuKien'] != null ? item['thoiGianDuKien'].substring(0, 10) : "",
                thoiGianThuHoiThe: item['thoiGianThuHoiThe'] != null ? item['thoiGianThuHoiThe'].substring(0, 16) : "",
                trangThaiThe: item['trangThaiThe'] == 0 ? "Yêu cầu hiệu chỉnh" :
                              item['trangThaiThe'] == 1 ? "Đang hoạt động" :
                              item['trangThaiThe'] == 2 ? "Đã khoá" : "Đã hoàn thành"
            );


            datas.add(newDataKBTModel);
          }
        }

        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<KeHoachModel>> getKeHoachByIdChuyenHang(String token, String listId) async {
    try {
      print("sâsa");
      List<KeHoachModel> datas = [];

      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(

        Uri.parse('$baseUrl2/KeHoachNew/getbyidchuyenhang/?listIdKeHoach=$listId'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            KeHoachModel newDataKBTModel = KeHoachModel(
              id: item['id'] ?? 0,
              stt: (datas.length + 1),
              chungTuCoSo: item['chungTuCoSo'] ?? "",
              soChungTuCoSo: item['soChungTuCoSo'] ?? "",
              thoiGianDuKien: item['thoiGianDuKien'] != null ? item['thoiGianDuKien'].substring(0, 10) : "",  // Handle date correctly
              hangMuc: item['hangMuc'] ?? "",
              maNhomHang1: item['maNhomHang1'] ?? "",
              tenNhomHang: item['tenNhomHang'] ?? "",
              moTaVatTu: item['moTaVatTu'] ?? "",
              nhaCungCap: item['nhaCungCap'] ?? "",
              soLuong: item['soLuong'].toString() ?? "0",
              donViTinh: item['donViTinh'] ?? "",
              tenBoPhan: item['tenBoPhan'] ?? "",
              viTriGiaoHang: item['viTriGiaoHang'] ?? "",
              nguoiNhanHang: item['nguoiNhanHang'] ?? "",
              soDienThoaiNguoiNhan: item['soDienThoaiNguoiNhan'] ?? "",
              bienSoXe: item['bienSoXe'] ?? "",
              soCccdLaiXe: item['soCccdLaiXe'] ?? "",
              hoTenLaiXe: item['hoTenLaiXe'] ?? "",
              soDienThoaiLaiXe: item['soDienThoaiLaiXe'] ?? "",
              ghiChu: item['ghiChu'] ?? "",
              congRaVao: item['congRaVao'] ?? "",
              maNhanVienKhoiTao: item['maNhanVienKhoiTao'] ?? "",
              thoiGianKhoiTao: item['thoiGianKhoiTao'] != null ? item['thoiGianKhoiTao'].substring(0, 10)+ " " + item['thoiGianKhoiTao'].substring(11, 16) : "",

            );
            datas.add(newDataKBTModel);
          }
        }

        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<XacNhanModel>> getXacNhanByIdChuyenHang(String token, String Id) async {
    try {
      List<XacNhanModel> datas = [];

      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(

        Uri.parse('$baseUrl2/XacNhan/getByIdChuyenHang/$Id'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            XacNhanModel newDataKBTModel = XacNhanModel(
              id: item['id'] ?? 0,
              ghiChu: item['ghiChu'] ?? "",
              loaiXacNhan: item['loaiXacNhan']==null?"":item['loaiXacNhan']==0?"Xe ra":"Xe vào",
              nhanVienXacNhan: item['nhanVienXacNhan']?? "",
              viTri: item['tenKho']== null? item['tenCong']??" ": item['tenKho']??" ",
              thoiGianXacNhan: item['thoiGianXacNhan'] != null ? item['thoiGianXacNhan'].substring(0, 10)+ " " + item['thoiGianXacNhan'].substring(11, 16) : "",


            );
            datas.add(newDataKBTModel);
          }
        }

        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<HieuChinhModel>> getHieuChinhByIdChuyenHang(String token, String Id) async {
    try {
      List<HieuChinhModel> datas = [];

      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(

        Uri.parse('$baseUrl2/HieuChinh/getHieuChinh/$Id'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            HieuChinhModel newDataKBTModel = HieuChinhModel(
              id: item['id'] ?? 0,
              noiDung: item['noiDung'] ?? "",
              loaiNoiDung: item['loaiNoiDung']??"",
              maNvThucTe: item['maNvThucTe']?? "",
              viTri: item['tenKho']== null? item['tenCong']??" ": item['tenKho']??" ",
              thoiGianYeuCau: item['thoiGianYeuCau'] != null ? item['thoiGianYeuCau'].substring(0, 10)+ " " + item['thoiGianYeuCau'].substring(11, 16) : "",
            );
            datas.add(newDataKBTModel);
          }
        }
        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<NoiDungHieuChinhModel>> getHieuChinh(String token) async {
    try {
      print("hieuchinh");
      List<NoiDungHieuChinhModel> datas = [];

      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(

        Uri.parse('$baseUrl2/NoiDungHieuChinh'),

        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            NoiDungHieuChinhModel newDataKBTModel = NoiDungHieuChinhModel(
              id: item['id'] ?? 0,
              trangThai: item['trangThai'] ?? 0,
              noiDungYeuCau: item['noiDungYeuCau'] ?? "",
            );
            if(newDataKBTModel.trangThai == 1){
              datas.add(newDataKBTModel);
            }
          }
        }
        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }


  static Future<void> CreateHieuChinhAction(BuildContext context, String token, CreateHieuChinhModel _body, Function setLoadding) async {
    try {
      // Convert the model to a Map and then to a JSON string
      Map<String, dynamic> bodyJson = _body.toJson();
      String jsonBody = jsonEncode(bodyJson); // Convert Map to JSON string

      String baseUrl2 = await LocalStory.getData();

      var response = await http.post(
        Uri.parse('$baseUrl2/hieuchinh/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",  // Add Bearer token
        },
        body: jsonBody, // Pass JSON string as the body
      );

      if (response.statusCode == 200) {
        // Success case
        ToastMessage.showMessageSuccess(context, "Yêu cầu hiệu chỉnh thành công");
        setLoadding();  // Reset loading state
      } else {
        // Failure case
        ToastMessage.showMessageError(context, "Yêu cầu hiệu chỉnh không thành công");
        setLoadding();  // Reset loading state
      }
    } catch (e) {
      print('Error: $e');
      // Catch any exceptions and display error message
      ToastMessage.showMessageError(context, "Yêu cầu hiệu chỉnh không thành công");
      setLoadding();  // Reset loading state
    }
  }


  static Future<void> CreateXacNhanAction(BuildContext context, String token, CreateXacNhanModel _body, Function setLoadding) async {
    try {
      // Convert the model to a Map and then to a JSON string
      Map<String, dynamic> bodyJson = _body.toJson();
      String jsonBody = jsonEncode(bodyJson); // Convert Map to JSON string

      String baseUrl2 = await LocalStory.getData();

      var response = await http.post(
        Uri.parse('$baseUrl2/XacNhan/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",  // Add Bearer token
        },
        body: jsonBody, // Pass JSON string as the body
      );

      if (response.statusCode == 200) {
        // Success case
        ToastMessage.showMessageSuccess(context, "Xác nhận thành công");
        setLoadding();  // Reset loading state
      } else {
        // Failure case
        ToastMessage.showMessageError(context, "Xác nhận không thành công");
        setLoadding();  // Reset loading state
      }
    } catch (e) {
      print('Error: $e');
      // Catch any exceptions and display error message
      ToastMessage.showMessageError(context, "Xác nhận không thành công");
      setLoadding();  // Reset loading state
    }
  }


  static Future<List<ChuyenHangModel>> getChuyenHangDaXacNhan(String token, String start, String end) async {
    try {
      print("sâsa");
      List<ChuyenHangModel> datas = [];
      // Subtract one day from the current date and format it
      // var formattedDate = DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);
      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(
        // Uri.parse('$baseUrl2/chuyenhangnew/GetByDateRangeXacNhan?startDate=$formattedDate&endDate=$formattedDate 23:59'),
        Uri.parse('$baseUrl2/chuyenhangnew/daterange?startDate=$start&endDate=$end 23:59'),
        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            ChuyenHangModel newDataKBTModel = ChuyenHangModel(
              // id: item['id'] ?? 0,  // Ensure `id` is converted to String
              // stt: (datas.length + 1),  // Ensure `stt` is converted to String
              // bienSoXe: item['bienSoXe'] ?? "",
              // congRaVao: item['congRaVao'] ?? "",
              // ghiChu: item['ghiChu'] ?? "",
              // hoTenLaiXe: item['hoTenLaiXe'] ?? "",
              // idKeHoach: item['idKeHoach'] ?? "",
              // maNhanVienCapThe: item['maNhanVienCapThe'] ?? "",
              // maNhanVienThuHoiThe: item['maNhanVienThuHoiThe'] ?? "",
              // nhanVienCapThe: item['nhanVienCapThe'] ?? "",
              // nhanVienThuHoiThe: item['nhanVienThuHoiThe'] ?? "",
              // soCccdLaiXe: item['soCccdLaiXe'] ?? "",
              // soDienThoaiLaiXe: item['soDienThoaiLaiXe'] ?? "",
              // soThe: item['soDienThoaiLaiXe'] ?? "Không",
              // thoiGianCapThe: item['thoiGianCapThe'] != null ? item['thoiGianCapThe'].substring(0, 16) : "",
              // thoiGianDuKien: item['thoiGianDuKien'] != null ? item['thoiGianDuKien'].substring(0, 10) : "",
              // thoiGianThuHoiThe: item['thoiGianThuHoiThe'] != null ? item['thoiGianThuHoiThe'].substring(0, 16) : "",
              // trangThaiThe: "oke"
              // This is a placeholder; modify as needed
                id: item['id'] ?? 0,  // Ensure `id` is converted to String
                stt: (datas.length + 1),  // Ensure `stt` is converted to String
                bienSoXe: item['bienSoXe'] ?? "",
                congRaVao: item['congRaVao'] ?? "",
                ghiChu: item['ghiChu'] ?? "",
                hoTenLaiXe: item['hoTenLaiXe'] ?? "",
                idKeHoach: item['idKeHoach'] ?? "",
                maNhanVienCapThe: item['maNhanVienCapThe'] ?? "",
                maNhanVienThuHoiThe: item['maNhanVienThuHoiThe'] ?? "",
                nhanVienCapThe: item['nhanVienCapThe'] ?? 0,
                nhanVienThuHoiThe: item['nhanVienThuHoiThe'] ?? 0,
                soCccdLaiXe: item['soCccdLaiXe'] ?? "",
                soDienThoaiLaiXe: item['soDienThoaiLaiXe'] ?? "",
                soThe: item['soThe'] ?? "Không",
                thoiGianCapThe: item['thoiGianCapThe'] != null ? item['thoiGianCapThe'].substring(0, 10)+ " " + item['thoiGianCapThe'].substring(11, 16) : "",
                thoiGianDuKien: item['thoiGianDuKien'] != null ? item['thoiGianDuKien'].substring(0, 10) : "",
                thoiGianThuHoiThe: item['thoiGianThuHoiThe'] != null ? item['thoiGianThuHoiThe'].substring(0, 16) : "",
                trangThaiThe: item['trangThaiThe'] == 0 ? "Yêu cầu hiệu chỉnh" :
                item['trangThaiThe'] == 1 ? "Đang hoạt động" :
                item['trangThaiThe'] == 2 ? "Đã khoá" : "Đã hoàn thành"
            );


            datas.add(newDataKBTModel);
          }
        }

        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }


  static Future<List<LichSuRaVaoModel>> getLichSuRaVao(String token, String start, String end) async {
    try {

      List<LichSuRaVaoModel> datas = [];
      String baseUrl2 = await LocalStory.getData();

      // Make the API call
      var response = await http.get(
        // Uri.parse('$baseUrl2/chuyenhangnew/GetByDateRangeXacNhan?startDate=$formattedDate&endDate=$formattedDate 23:59'),
        Uri.parse('$baseUrl2/xacnhan/GetByDateRange?startDate=$start&endDate=$end 23:59'),
        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " + token},
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        // Iterate over the response data (which is likely a list)
        for (var item in responseData) {
          if (item is Map<dynamic, dynamic>) {
            LichSuRaVaoModel newDataKBTModel = LichSuRaVaoModel(
                stt: (datas.length + 1),
                id: item['id'] ?? 0,
                soThe: item['soThe'] ?? "Không",
                bienSoXe: item['bienSoXe'] ?? "",
                tenCong: item['tenCong'] ?? "",
                loaiXacNhan: item['loaiXacNhan'] == 1?"Xe vào": "Xe ra",
                thoiGianXacNhan: item['thoiGianXacNhan'] != null ? item['thoiGianXacNhan'].substring(0, 10)+ " " + item['thoiGianXacNhan'].substring(11, 16) : "",
                nhanVienXacNhan: item['nhanVienXacNhan'] ?? "",
                congRaVao: item['congRaVao'] ?? "",
                ghiChu: item['ghiChu'] ?? "",
                hoTenLaiXe: item['hoTenLaiXe'] ?? "",
                idKeHoach: 0,
                maNhanVienCapThe: item['maNhanVienCapThe'] ?? "",
                maNhanVienThuHoiThe: item['maNhanVienThuHoiThe'] ?? "",
                nhanVienCapThe: item['nhanVienCapThe'] ?? 0,
                nhanVienThuHoiThe: item['nhanVienThuHoiThe'] ?? 0,
                soCccdLaiXe: item['soCccdLaiXe'] ?? "",
                soDienThoaiLaiXe: item['soDienThoaiLaiXe'] ?? "",

                thoiGianCapThe: item['thoiGianCapThe'] != null ? item['thoiGianCapThe'].substring(0, 10)+ " " + item['thoiGianCapThe'].substring(11, 16) : "",
                thoiGianDuKien: item['thoiGianDuKien'] != null ? item['thoiGianDuKien'].substring(0, 10) : "",
                thoiGianThuHoiThe: item['thoiGianThuHoiThe'] != null ? item['thoiGianThuHoiThe'].substring(0, 16) : "",
                trangThaiThe: item['trangThaiThe'] == 0 ? "Yêu cầu hiệu chỉnh" :
                item['trangThaiThe'] == 1 ? "Đang hoạt động" :
                item['trangThaiThe'] == 2 ? "Đã khoá" : "Đã hoàn thành",

            );


            datas.add(newDataKBTModel);
          }
        }

        return datas;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}



