import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/actions/getAction.dart';
import 'package:ra_soat_ra_vao/components/CardComponent.dart';
import 'package:ra_soat_ra_vao/models/KeHoachTuanKiem.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';
import 'package:ra_soat_ra_vao/widgets/CustomScaffoldLayout.dart';
import 'package:provider/provider.dart';

import '../models/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //   List<TableRow> listItem = [];
  //
  // Future<void> getDataKeHoach(token) async {
  //   List<KeHoachTuanKiem> datas = await GetAction.getKeHoach(token ?? "");
  //   datas.sort((a, b) => a.trangThai.compareTo(b.trangThai));
  //   List<TableRow> _listItem = [
  //     TableRow(
  //       children: [
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('STT', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('BP/NM', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('PX', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Phòng điện', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Tháng', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Số lần', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Mức độ', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //         Container(
  //           color: Colors.yellow,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Trạng thái', style: TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //       ],
  //     )
  //   ];
  //   print(datas);
  //   for (int i = 0; i < datas.length ; i++) {
  //     //chưa hoàn thành
  //     if(datas[i].trangThai == 0){
  //       TableRow item = TableRow(
  //         children: [
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text((i+1).toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].boPhan.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].phanXuong.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].tenPhong.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].thang.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].soLanDo.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child:  datas[i].mucDo == 1? Text("Thấp"): datas[i].mucDo == 2? Text("Trung bình"): Text("Cao"),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x917CBCFF),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('Chưa hoàn thành'),
  //             ),
  //           ),
  //         ],
  //       );
  //       _listItem.add(item);
  //     }
  //     //Hoàn thành
  //     else if(datas[i].trangThai == 1){
  //       TableRow item = TableRow(
  //         children: [
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text((i+1).toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].boPhan.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].phanXuong.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].tenPhong.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].thang.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].soLanDo.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child:  datas[i].mucDo == 1? Text("Thấp"): datas[i].mucDo == 2? Text("Trung bình"): Text("Cao"),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x9143EF49),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('Đã hoàn thành'),
  //             ),
  //           ),
  //         ],
  //       );
  //       _listItem.add(item);
  //     }
  //     //Đã khoá
  //     else{
  //       TableRow item = TableRow(
  //         children: [
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text((i+1).toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].boPhan.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].phanXuong.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].tenPhong.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].thang.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(datas[i].soLanDo.toString()),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child:  datas[i].mucDo == 1? Text("Thấp"): datas[i].mucDo == 2? Text("Trung bình"): Text("Cao"),
  //             ),
  //           ),
  //           Container(
  //             color: Color(0x91DEDDDD),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('Đã khoá'),
  //             ),
  //           ),
  //         ],
  //       );
  //       _listItem.add(item);
  //
  //     }
  //
  //
  //
  //
  //
  //   }
  //   setState(() {
  //     listItem = _listItem;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    // Use a post-frame callback to ensure the context is valid
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      User? user = Provider.of<AuthProvider>(context, listen: false).user;
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/login");
        // or Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print("User is logged in.");
        // print("12233");
        // getDataKeHoach(user.token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldLayout(
        selected: 0,
        children: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
            children: [
              CardComponent(),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   "Kế Hoạch Tuần kiểm",
              //   style: TextStyle(color: Color(0xff194689), fontSize: 16, fontFamily: "RobotoBold", fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Table(
              //     border: TableBorder.all(), // Adds a border around the table
              //     columnWidths: {
              //       0: FixedColumnWidth(50), // Set custom width for column 0
              //       1: FixedColumnWidth(120),
              //       2: FixedColumnWidth(200),
              //       3: FixedColumnWidth(200),
              //       4: FixedColumnWidth(80), // Set custom width for column 0
              //       5: FixedColumnWidth(80),
              //       6: FixedColumnWidth(120),
              //       7: FixedColumnWidth(160),// Set custom width for column 1
              //     },
              //     children: listItem,
              //     // children: [
              //     //   // TableRow 1
              //     //   TableRow(
              //     //
              //     //     children: [
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('STT', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('BP/NM', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('PX', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('Phòng điện', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('Tháng', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('Số lần', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('Mức độ', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //       Container(
              //     //         color: Colors.yellow,
              //     //         child: Padding(
              //     //           padding: const EdgeInsets.all(8.0),
              //     //           child: Text('Trạng thái', style: TextStyle(fontWeight: FontWeight.bold)),
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     //   // TableRow 2
              //     //   // TableRow(
              //     //   //   children: [
              //     //   //     Padding(
              //     //   //       padding: const EdgeInsets.all(8.0),
              //     //   //       child: Text('1'),
              //     //   //     ),
              //     //   //     Padding(
              //     //   //       padding: const EdgeInsets.all(8.0),
              //     //   //       child: Text('Alice'),
              //     //   //     ),
              //     //   //   ],
              //     //   // ),
              //     //   // TableRow 3
              //     // ],
              //   ),
              // )
            ],
          ),
        ));
  }
}
