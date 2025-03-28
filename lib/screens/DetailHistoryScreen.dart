import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ra_soat_ra_vao/actions/getAction.dart';
import 'package:ra_soat_ra_vao/configs/toast_message.dart';
import 'dart:core';

import 'package:ra_soat_ra_vao/models/ChuyenHangModel.dart';
import 'package:ra_soat_ra_vao/models/CreateHieuChinhModel.dart';
import 'package:ra_soat_ra_vao/models/CreateXacNhanModel.dart';
import 'package:ra_soat_ra_vao/models/HieuChinhModel.dart';
import 'package:ra_soat_ra_vao/models/KeHoachModel.dart';
import 'package:ra_soat_ra_vao/models/NoiDungHieuChinhModel.dart';
import 'package:ra_soat_ra_vao/models/TruyenModel.dart';
import 'package:ra_soat_ra_vao/models/dropdown_value_model.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';
import 'package:ra_soat_ra_vao/models/user_provider.dart';
import 'package:ra_soat_ra_vao/screens/XacNhanModel.dart';
import 'package:ra_soat_ra_vao/widgets/CustomTextFormFieldChecking.dart';
import 'package:provider/provider.dart';
class DetailHistoryScreen extends StatefulWidget {
  DetailHistoryScreen({super.key});

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  bool loadding = false;
  bool loaddingsend = false;
  User? user;
  ChuyenHangModel? chuyenHang;
  List<KeHoachModel> keHoachs = [];
  List<DataRow> listItem = [];
  List<Widget> listXacNhans = [];
  List<Widget> listHieuChinhs = [];

  List<DropdownValue> listNoiDungYeuCau = [];

  @override
  void dispose() {
    super.dispose();
  }
  void onChangeLoaddingSend() {
    setState(() {
      loaddingsend = false;
    });
  }

  Future<void> getDataKeHoach(String? token, String listId, String idChuyenHang) async {
    setState(() {
      loadding = true;
    });

    try {
      List<KeHoachModel> datas = await GetAction.getKeHoachByIdChuyenHang(token ?? "",listId);
      List<XacNhanModel> xacNhans = await GetAction.getXacNhanByIdChuyenHang(token ?? "", idChuyenHang);
      List<HieuChinhModel> hieuChinhs = await GetAction.getHieuChinhByIdChuyenHang(token ?? "", idChuyenHang);
      List<Widget> listXN = [];
      for(int i = 0; i < xacNhans.length; i++){
        Widget newWidget = Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.greenAccent
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vị trí:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          xacNhans[i].viTri.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ra/vào:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          xacNhans[i].loaiXacNhan.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thời gian:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          xacNhans[i].thoiGianXacNhan.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mã CBNV:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          xacNhans[i].nhanVienXacNhan.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ghi chú:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    xacNhans[i].ghiChu.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),

            ],
          ),
        );
        listXN.add(newWidget);
      }

      for(int i = 0; i < hieuChinhs.length; i++){
        Widget newWidget = Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0XFFFCA29A)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vị trí:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          hieuChinhs[i].viTri.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Loại hiệu chỉnh:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          hieuChinhs[i].loaiNoiDung.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thời gian:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          hieuChinhs[i].thoiGianYeuCau.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mã CBNV:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(
                          hieuChinhs[i].maNvThucTe.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nội dung:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Text(
                    hieuChinhs[i].noiDung.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),

            ],
          ),
        );
        listHieuChinhs.add(newWidget);
      }

      setState(() {
        keHoachs = datas;
        listXacNhans = listXN;


      });
      setChuyenHang();

      // setChuyenHang(_searchKhacController.text);
    } catch (e) {
      // Bạn có thể xử lý lỗi hoặc hiển thị thông báo khi có lỗi xảy ra
      print("Error fetching data: $e");
    }
  }



  setChuyenHang() {
    List<DataRow> listItemFirst = [];
    var n = 0;
    for (int i = 0; i < keHoachs.length; i++) {

        n++;
        DataRow listItemRow = DataRow(
          cells: [
            // STT Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Center(child: Text((n ?? 0).toString())), // Display 'n' or fallback to 0
            )),

            // Ngày dự kiến Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].thoiGianDuKien ?? ""),
            )),

            // Chứng từ cơ sở Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].chungTuCoSo ?? ""),
            )),

            // Số chứng từ cơ sở Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].soChungTuCoSo ?? ""),
            )),

            // Hạng mục Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].hangMuc ?? ""),
            )),

            // Mã nhóm hàng Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].maNhomHang1 ?? ""),
            )),

            // Phân loại nhóm hàng Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].tenNhomHang ?? ""),
            )),

            // Mô tả vật tư Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].moTaVatTu ?? ""),
            )),

            // Nhà cung cấp Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].nhaCungCap ?? ""),
            )),

            // Số lượng Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text((keHoachs[i].soLuong ?? 0).toString()), // Assuming soLuong is an integer
            )),

            // Đơn vị tính Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].donViTinh ?? ""),
            )),

            // Bộ phận nhận hàng Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].tenBoPhan ?? ""),
            )),

            // Vị trí giao hàng Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].viTriGiaoHang ?? ""),
            )),

            // Người nhận hàng Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].nguoiNhanHang ?? ""),
            )),

            // SĐT người nhận Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].soDienThoaiNguoiNhan ?? ""),
            )),

            // Biển số xe Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].bienSoXe ?? ""),
            )),

            // Họ tên lái xe Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].hoTenLaiXe ?? ""),
            )),

            // Số CCCD lái xe Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].soCccdLaiXe ?? ""),
            )),

            // SĐT lái xe Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].soDienThoaiLaiXe ?? ""),
            )),

            // Cổng ra vào Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].congRaVao ?? ""),
            )),

            // Ghi chú Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].ghiChu ?? ""),
            )),

            // Mã NV khởi tạo Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].maNhanVienKhoiTao ?? ""),
            )),

            // Thời gian khởi tạo Column
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(keHoachs[i].thoiGianKhoiTao ?? ""),
            )),
          ],

        );
        listItemFirst.add(listItemRow);  // Thêm dòng vào danh sách

    }
    setState(() {
      listItem = listItemFirst;  // Cập nhật danh sách DataRow
      loadding = false;  // Thay đổi trạng thái loading
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Lấy dữ liệu truyền qua `arguments`
      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments != null && arguments is ChuyenHangModel) {
        setState(() {
          chuyenHang = arguments;

        });

        user = Provider.of<AuthProvider>(context, listen: false).user;
        if (user != null) {
         getDataKeHoach(user?.token??"", arguments!.idKeHoach??"", arguments.id.toString());
        }


           // Gán dữ liệu vào biến
      } else {
        // Xử lý nếu không có dữ liệu hoặc dữ liệu không hợp lệ
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: const Text("Chi tiết chuyến hàng", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
      ),
      body: loadding? Center(child: CircularProgressIndicator( color: Colors.blue,),): Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Column: Số thẻ
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Số thẻ", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.soThe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // Second Column: Biển số xe
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Biển số xe", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.bienSoXe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // Third Column: Ngày
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ngày", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.thoiGianDuKien.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Column: Họ tên
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Họ tên", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.hoTenLaiXe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // Second Column: Số CCCD
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Số CCCD", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.soCccdLaiXe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // Third Column: SĐT
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SĐT", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.soDienThoaiLaiXe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Column: Mã NV tạo
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mã NV tạo", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.maNhanVienCapThe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // Second Column: Thời gian khởi tạo
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Thời gian khởi tạo", style: TextStyle(fontSize: 12)),
                            Text(
                              chuyenHang!.thoiGianCapThe.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Text("Danh sách kế hoạch", style: TextStyle( fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue),
                    dataRowMaxHeight: double.infinity,       // Code to be changed.
                    dataRowMinHeight: 60,
                    border: TableBorder.all(),
                    columns: const [
                      DataColumn(label: Center(child: Text('STT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Ngày dự kiến', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Chứng từ cơ sở', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Số chứng từ cơ sở', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Hạng mục', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Mã nhóm hàng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Phân loại nhóm hàng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Mô tả vật tư', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Nhà cung cấp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Số lượng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Đơn vị tính', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Bộ phận nhận hàng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Vị trí giao hàng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Người nhận hàng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('SĐT người nhận', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Biển số xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Họ tên lái xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Số CCCD lái xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('SĐT lái xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Cổng ra vào', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Ghi chú', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Mã NV khởi tạo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Thời gian khởi tạo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                    ],
                    rows: listItem,
                  ),
                ),
                SizedBox(height: 18),
                Text("Yêu cầu hiệu chỉnh", style: TextStyle( fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                ...listHieuChinhs,
                SizedBox(height: 10),
                Text("Danh sách xác nhận", style: TextStyle( fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                ...listXacNhans,
                SizedBox(height: 15),

                // Container(
                //   margin: EdgeInsets.only(bottom: 10),
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.greenAccent
                //   ),
                //   child: const Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Vị trí:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "Cổng Bình Đông 2",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Ra/vào:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "Xe ra",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Row(
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Thời gian:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "2025-01-07 16:02",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Mã CBNV:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "HPDQ00211",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text("Ghi chú:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //           Text(
                //             "nânjsậ ka ạ",
                //             style: TextStyle(fontSize: 12),
                //           ),
                //         ],
                //       ),
                //
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 10),
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.greenAccent
                //   ),
                //   child: const Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Vị trí:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "Cổng Bình Đông 2",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Ra/vào:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "Xe ra",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Row(
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Thời gian:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "2025-01-07 16:02",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Mã CBNV:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "HPDQ00211",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text("Ghi chú:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //           Text(
                //             "nânjsậ ka ạ",
                //             style: TextStyle(fontSize: 12),
                //           ),
                //         ],
                //       ),
                //
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 10),
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.greenAccent
                //   ),
                //   child: const Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Vị trí:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "Cổng Bình Đông 2",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Ra/vào:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "Xe ra",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Row(
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Thời gian:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "2025-01-07 16:02",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Mã CBNV:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //                 Text(
                //                   "HPDQ00211",
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text("Ghi chú:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                //           Text(
                //             "nânjsậ ka ạ",
                //             style: TextStyle(fontSize: 12),
                //           ),
                //         ],
                //       ),
                //
                //     ],
                //   ),
                // ),

              ],
            ),
          ),
        ),


    );
  }


}



