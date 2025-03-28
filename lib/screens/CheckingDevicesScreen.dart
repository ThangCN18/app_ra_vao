import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:core';

import 'package:ra_soat_ra_vao/actions/getAction.dart';
import 'package:ra_soat_ra_vao/models/ChuyenHangModel.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';
import 'package:ra_soat_ra_vao/models/user_provider.dart';
import 'package:ra_soat_ra_vao/widgets/CustomScaffoldLayout.dart';
import 'package:provider/provider.dart';

class CheckingDevicesScreen extends StatefulWidget {
  CheckingDevicesScreen({super.key});

  @override
  State<CheckingDevicesScreen> createState() => _CheckingDevicesScreenState();
}

class _CheckingDevicesScreenState extends State<CheckingDevicesScreen> {
  bool loadding = false;
  bool loaddingsend = false;
  TextEditingController _dateStartController = TextEditingController();
  TextEditingController _dateEndController = TextEditingController();
  TextEditingController _searchKhacController = TextEditingController();
  List<ChuyenHangModel> ChuyenHangs = [];
  List<DataRow> listItem = [];

  Future<void> getDataKeHoach(String? token, String start, String end) async {
    setState(() {
      loadding = true;
    });

    try {
      List<ChuyenHangModel> datas = await GetAction.getChuyenHang(token ?? "",start, end);
      setState(() {
        ChuyenHangs = datas;
      });
      setChuyenHang(_searchKhacController.text);
    } catch (e) {
      // Bạn có thể xử lý lỗi hoặc hiển thị thông báo khi có lỗi xảy ra
      print("Error fetching data: $e");
    }
  }

  setChuyenHang(String textSearch) {
    List<DataRow> listItemFirst = [];
    var n = 0;
    for (int i = 0; i < ChuyenHangs.length; i++) {
      if (ChuyenHangs[i].soThe!.trim().toLowerCase().contains(textSearch.toLowerCase().trim())||
          ChuyenHangs[i].bienSoXe!.trim().toLowerCase().contains(textSearch.toLowerCase().trim())||
          ChuyenHangs[i].hoTenLaiXe!.trim().toLowerCase().contains(textSearch.toLowerCase().trim())||
          ChuyenHangs[i].soCccdLaiXe!.trim().toLowerCase().contains(textSearch.toLowerCase().trim())||
          ChuyenHangs[i].soDienThoaiLaiXe!.trim().toLowerCase().contains(textSearch.toLowerCase().trim())||
          ChuyenHangs[i].congRaVao!.trim().toLowerCase().contains(textSearch.toLowerCase().trim())
      ) {
        n++;
        DataRow listItemRow = DataRow(
          cells: [
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: IconButton(
                onPressed: () => {
                Navigator.pushNamed(
                context,
                '/detailship',
                arguments: ChuyenHangs[i],
                )
                              },
                icon: Icon(Icons.remove_red_eye_rounded, color: Colors.lightBlue),
              ),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Center(child: Text(n.toString() ?? "")),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].soThe ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].bienSoXe ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].hoTenLaiXe ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].soCccdLaiXe ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].soDienThoaiLaiXe ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].congRaVao ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].thoiGianDuKien ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].maNhanVienCapThe ?? ""),
            )),
            DataCell(Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(ChuyenHangs[i].thoiGianCapThe ?? ""),
            )),
          ],
        );
        listItemFirst.add(listItemRow);  // Thêm dòng vào danh sách
      }
    }
    setState(() {
      listItem = listItemFirst;  // Cập nhật danh sách DataRow
      loadding = false;  // Thay đổi trạng thái loading
    });
  }



  User? user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      user = Provider.of<AuthProvider>(context, listen: false).user;
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/login");
      } else {

        var formattedDate = DateTime.now().toString().substring(0, 10);
        var today = DateTime.now();
        var dateFiveDaysAgo = today.subtract(Duration(days: 5));
        _dateEndController.text= formattedDate;

        // Định dạng lại ngày theo kiểu 'yyyy-MM-dd'
        var formattedDate2 = "${dateFiveDaysAgo.year}-${dateFiveDaysAgo.month.toString().padLeft(2, '0')}-${dateFiveDaysAgo.day.toString().padLeft(2, '0')}";
        _dateStartController.text=formattedDate2;
        getDataKeHoach(user?.token, formattedDate2, formattedDate);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> selectStartDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      _dateStartController.text = _picked.toString().split(" ")[0];
    }
  }

  onChangeSearch(value) {
    if (value != null) {
      _searchKhacController.text = value.toString();
      // setChuyenHang(value);
    }
  }



  Future<void> selectEndDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      _dateEndController.text = _picked.toString().split(" ")[0];
    }
  }

  void onChangeLoaddingSend() {
    setState(() {
      loaddingsend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadding) {
      return CustomScaffoldLayout(
          selected: 1,
          children: Center(child: CircularProgressIndicator(color: Colors.blue,)));
    } else {
      return CustomScaffoldLayout(
        selected: 1,
        children: Flex(
          direction: Axis.vertical,
          children: [
            Padding(padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Từ ngày"),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: _dateStartController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xff9a9a9a)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xff9a9a9a)),
                            ),
                          ),
                          onTap: selectStartDate,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Đến ngày"),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: _dateEndController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xff9a9a9a)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xff9a9a9a)),
                            ),
                          ),
                          onTap: selectEndDate,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                        onPressed: ()=>{
                          getDataKeHoach(user?.token, _dateStartController.text, _dateEndController.text)

                        },
                        color: Colors.lightBlue,
                        padding: EdgeInsets.all(2),
                        iconSize: 20,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey),

                        ),
                        icon: Icon(Icons.search, color: Colors.white,)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        TextFormField(
                          controller: _searchKhacController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xff9a9a9a)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xff9a9a9a)),
                            ),
                          ),
                          onChanged: onChangeSearch,
                          onFieldSubmitted: (value) {
                            if (value != null && value.isNotEmpty) {
                              setChuyenHang(value);
                            }
                          },
                        ),
                      ],
                    ),
                  ), // Bạn có thể thay thế đoạn này bằng thông tin phù hợp
                ],
              ),
            ),
            SizedBox(height: 8,),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue),
                    columns: const [
                      DataColumn(label: Center(child: Text('Action', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('STT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Số thẻ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Biển số xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Họ tên lái xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Số CCCD lái xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('SĐT lái xe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Cổng ra vào', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Ngày dự kiến', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Mã NV khởi tạo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      DataColumn(label: Center(child: Text('Thời gian khởi tạo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                    ],
                    rows: listItem,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
