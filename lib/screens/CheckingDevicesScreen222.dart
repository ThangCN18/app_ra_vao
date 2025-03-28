import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "dart:ui";
import 'dart:core';

import "package:ra_soat_ra_vao/actions/getAction.dart";
import "package:ra_soat_ra_vao/configs/toast_message.dart";
import "package:ra_soat_ra_vao/models/CreateTuanKiemModel.dart";
import "package:ra_soat_ra_vao/models/DiaDiemModel.dart";
import "package:ra_soat_ra_vao/models/dropdown_value_model.dart";
import "package:ra_soat_ra_vao/models/user_model.dart";
import "package:ra_soat_ra_vao/models/user_provider.dart";
import "package:ra_soat_ra_vao/widgets/CustomDropdownButtonFormField.dart";
import "package:ra_soat_ra_vao/widgets/CustomElevatedButton.dart";
import "package:ra_soat_ra_vao/widgets/CustomScaffoldLayout.dart";
import "package:provider/provider.dart";


class CheckingDevicesScreen extends StatefulWidget {
  CheckingDevicesScreen({super.key});

  @override
  State<CheckingDevicesScreen> createState() => _CheckingDevicesScreenState();
}

class _CheckingDevicesScreenState extends State<CheckingDevicesScreen> {
  bool loading = true;
  bool loadingPost = false;
  List<DropdownValue> listPhanXuongs = [];
  List<DropdownValue> listNhaMays = [];
  List<DropdownValue> listPhongDiens = [];

  TextEditingController _nhaMayController = TextEditingController();
  TextEditingController _mucDoBuiController = TextEditingController();
  TextEditingController _mucDoAmController = TextEditingController();
  TextEditingController _heThongLamMatController = TextEditingController();
  TextEditingController _tinhTrangThietBiController = TextEditingController();
  TextEditingController _emcController = TextEditingController();
  TextEditingController _lapDatController = TextEditingController();
  TextEditingController _baoLoiController = TextEditingController();
  TextEditingController _ketLuanController = TextEditingController();

  TextEditingController _thongTinKhacController = TextEditingController();
  TextEditingController _phanXuongController = TextEditingController();
  TextEditingController _phongDienController = TextEditingController();
  TextEditingController _nhietDoController = TextEditingController();
  TextEditingController _doAmController = TextEditingController();
  TextEditingController _moiTruongVanHanhKhacController = TextEditingController();

  TextEditingController _maLoiController = TextEditingController();
  TextEditingController _noiDungKetLuanController = TextEditingController();
  TextEditingController _deXuatController = TextEditingController();
  TextEditingController _KTVNMController = TextEditingController();



  List<DropdownValue> listMucDoBuis = [
    DropdownValue(title: "Sạch sẽ", value: "Sạch sẽ"),
    DropdownValue(title: "Bình thường", value: "Bình thường"),
    DropdownValue(title: "Bụi bẩn", value: "Bụi bẩn")
  ];
  List<DropdownValue> listDoAms = [
    DropdownValue(title: "Khô ráo", value: "Khô ráo"),
    DropdownValue(title: "Bình thường", value: "Bình thường"),
    DropdownValue(title: "Ẩm ướt", value: "Ẩm ướt")
  ];

  List<DropdownValue> listTinhTrangThietBi = [
    DropdownValue(title: "Sạch sẽ", value: "Sạch sẽ"),
    DropdownValue(title: "Bình thường", value: "Bình thường"),
    DropdownValue(title: "Bụi bẩn", value: "Bụi bẩn")
  ];

  void onChangeLamMatRadio(String? value) {
    if (mounted) {
      if (value != null) {
        setState(() {
          _heThongLamMatController.text = value;
        });
      } // Update the selected value
    }
  }

  void onChangeEMCRadio(String? value) {
    if (mounted) {
      if (value != null) {
        setState(() {
          _emcController.text = value;
        });
      } // Update the selected value
    }

  }

  void resetAllFie()=>{
  setState(() {
  _nhaMayController.text="";
  _phanXuongController.text = "";
  _phongDienController.text = "";
  _nhietDoController.text = "";
  _mucDoBuiController.text = "";
  _doAmController.text = "";
  _moiTruongVanHanhKhacController.text = "";
  _heThongLamMatController.text = "1";
  _emcController.text = "1";
  _lapDatController.text = "1";
  _baoLoiController.text = "1";
  _ketLuanController.text = "1";
  _tinhTrangThietBiController.text = "";
  _maLoiController.text = "";
  _thongTinKhacController.text = "";
  _noiDungKetLuanController.text = "";
  _deXuatController.text = "";
  _KTVNMController.text = "";
  })
  };

  void onChangeKetLuanRadio(String? value) {
    if (mounted) {
      if (value != null) {
        setState(() {
          _ketLuanController.text = value;
        });
      } // Update the selected value
    }
  }


  void onChangeLoiRadio(String? value) {
    if (mounted) {
      if (value != null) {
        setState(() {
          _baoLoiController.text = value;
        });
      } // Update the selected value
    }
  }


  void onChangeLapDatEMCRadio(String? value) {
    if (mounted) {
      if (value != null) {
        setState(() {
          _lapDatController.text = value;
        });
      } // Update the selected value
    }
  }

  List<TextEditingController> controllersChiSoDO = [];
  User? user;
  bool loadding = false;
  bool loaddingsend = false;
  @override
  void initState() {
    super.initState();
    print(DateTime.now());
    _heThongLamMatController.text = "1";
    _emcController.text = "1";
    _lapDatController.text = "1";
    _baoLoiController.text = "1";
    _ketLuanController.text = "1";
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      User? user = Provider.of<AuthProvider>(context, listen: false).user;
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/login");
        // or Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print("User is logged in.");
      }
    });

    _fetchNhaMay();
  }


  @override
  void dispose() {
    for (int i = 0; i < controllersChiSoDO.length; i++) {
      controllersChiSoDO[i].dispose();
    }
    super.dispose();
  }

  void startTimeout() {
    Future.delayed(Duration(seconds: 3), () {
     // EasyLoading.dismiss();
     setState(() {
       loading = false;
     });
    });
  }

  onChangeMucDoBuiValue(String value) {
      _mucDoBuiController.text = value;
  }

  onChangeTinhTrangThietBiValue(String value) {
      _tinhTrangThietBiController.text = value;
  }

  onChangeDoAmValue(String value) {
      _mucDoAmController.text = value;
   }

  onChangeNhaMayValue(value) {

    _nhaMayController.text = value;

    if(value != ""){
      _phanXuongController.text = "";
      _phongDienController.text = "";
      setState(() {
        listPhanXuongs = [];
        listPhongDiens = [];
      });
      _fetchPhanXuong(int.parse(value));

    }
  }

  onChangePhanXuongValue(value) {
      _phanXuongController.text = value;

      if(value != ""){
        _phongDienController.text = "";
        setState(() {
         listPhongDiens = [];
        });
        _fetchPhongDien(int.parse(value));
      }

  }
  onChangePhongDienValue(value) {

      _phongDienController.text = value;

    }


  void onChangeLoaddingSend(){
    setState(() {
      loaddingsend = false;
    });
  }

  void onChangeLoaddingSendSet(){
    setState(() {
      loaddingsend = true;
    });
  }


  Future<void> _fetchNhaMay() async {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      try {
        // await GetAction.getChuyenHang(user!.token ?? "");
        List<DiaDiemModel> listData =
        await GetAction.getDiaDiem(user!.token ?? "", 1);
        setState(() {

          listNhaMays = listData.length!=0?listData
              .map((item) => DropdownValue(
            title: item.maDiaDiem.toString(),
            value: item.id.toString(),
          ))
              .toList(): [];
        });

      } catch (e) {
        // Handle error
        print('Error fetching LinhKien: $e');
      }
    }
  }


  Future<void> _fetchPhanXuong(int cap) async {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      try {

        List<DiaDiemModel> listData =
        await GetAction.getDiaDiem(user!.token ?? "", cap);
        setState(() {
          listPhanXuongs = listData.length!=0?listData
              .map((item) => DropdownValue(
            title: item.tenDiaDiem.toString(),
            value: item.id.toString(),
          ))
              .toList(): [];
        });

      } catch (e) {
        // Handle error
        print('Error fetching LinhKien: $e');
      }
    }
  }

  Future<void> _fetchPhongDien(int cap) async {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      try {
        List<DiaDiemModel> listData =
        await GetAction.getDiaDiem(user!.token ?? "", cap);
        setState(() {
          listPhongDiens = listData.length!=0?listData
              .map((item) => DropdownValue(
            title: item.tenDiaDiem.toString(),
            value: item.id.toString(),
          ))
              .toList(): [];
        });
      } catch (e) {
        print('Error fetching LinhKien: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formChecking = GlobalKey<FormState>();
      if(loadding){
        return CustomScaffoldLayout(
            selected: 1,
            children: Center(child: CircularProgressIndicator(color: Colors.blue,))
        );
      }
      else{
        return  CustomScaffoldLayout(
            selected: 1,
            children:ListView(
              key: PageStorageKey<String>('checking_devices'),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tuần kiểm phòng điện",
                      style: TextStyle(color: Color(0xff194689), fontSize: 18, fontFamily: "RobotoBold", fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 5),
                Form(
                  key: _formChecking,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Bộ phận/Nhà máy",
                          ),
                        ),
                      ),
                      CustomDropdownButtonFormField(
                        items: listNhaMays,
                        hintTextValue: "Lựa chọn BP/NM",
                        changeValue: onChangeNhaMayValue,
                        textValue: _nhaMayController.text,
                        textLongbool: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phân xưởng",
                          ),
                        ),
                      ),
                      CustomDropdownButtonFormField(
                        items: listPhanXuongs,
                        hintTextValue: "Lựa chọn phân xưởng",
                        changeValue: onChangePhanXuongValue,
                        textValue: _phanXuongController.text,
                        textLongbool: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phòng điện",
                          ),
                        ),
                      ),
                      CustomDropdownButtonFormField(
                        items: listPhongDiens,
                        hintTextValue: "Lựa chọn phòng điện",
                        changeValue: onChangePhongDienValue,
                        textValue: _phongDienController.text,
                        textLongbool: true,
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Điều kiện môi trường vận hành", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 3),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Nhiệt độ",
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value)=>{
                                      _nhietDoController.text = value
                                    },
                                    controller: _nhietDoController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          gapPadding: 0,
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xff9a9a9a),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color(0xff9a9a9a),
                                        )),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 3),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Mức độ bụi",
                                      ),
                                    ),
                                  ),
                                  CustomDropdownButtonFormField(
                                    items: listMucDoBuis,
                                    hintTextValue: "Lựa chọn",
                                    changeValue: onChangeMucDoBuiValue,
                                    textValue: _mucDoBuiController.text,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 3),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Độ ẩm",
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value)=>{
                                        _doAmController.text = value
                                    },
                                    controller: _doAmController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          gapPadding: 0,
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xff9a9a9a),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          gapPadding: 0,
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color(0xff9a9a9a),
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 3),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Mức độ ẩm",
                                      ),
                                    ),
                                  ),
                                  CustomDropdownButtonFormField(
                                    items: listDoAms,
                                    hintTextValue: "Lựa chọn",
                                    changeValue: onChangeDoAmValue,
                                    textValue: _mucDoAmController.text,
                                  ),
                                ],
                              )),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Khác",
                          ),
                        ),
                      ),
                      TextFormField(
                          controller: _moiTruongVanHanhKhacController,
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                            focusedBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                          ),
                          onChanged: (value) {
                            _moiTruongVanHanhKhacController.text = value;
                          }),

                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Hệ thống làm mát", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(width: 10,),
                            Radio<String>(value: "1", groupValue: _heThongLamMatController.text, onChanged: onChangeLamMatRadio, activeColor: Colors.blue,),
                            Text("Có"),
                            SizedBox(width: 2,),
                            Radio<String>(value: "0", groupValue: _heThongLamMatController.text, onChanged: onChangeLamMatRadio, activeColor: Colors.blue),
                            Text("Không"),
                          ],
                        ),
                      ),


                      Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 3),
                         child: _heThongLamMatController.text == "1"?Column(
                           children: [
                             const Padding(
                               padding: EdgeInsets.only(top: 5, bottom: 3),
                               child: Align(
                                 alignment: Alignment.centerLeft,
                                 child: Text(
                                   "Tình trạng thiết bị",
                                 ),
                               ),
                             ),
                             CustomDropdownButtonFormField(
                               items: listTinhTrangThietBi,
                               hintTextValue: "Lựa chọn",
                               changeValue: onChangeTinhTrangThietBiValue,
                               textValue: _tinhTrangThietBiController.text,
                             ),
                           ]
                         ):SizedBox(width: 1,)),

                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("EMC-filters", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(width: 10,),
                            Radio<String>(value: "1", groupValue: _emcController.text, onChanged: onChangeEMCRadio, activeColor: Colors.blue,),
                            Text("Có"),
                            SizedBox(width: 2,),
                            Radio<String>(value: "0", groupValue: _emcController.text, onChanged: onChangeEMCRadio, activeColor: Colors.blue),
                            Text("Không"),
                          ],
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 3),
                          child: _emcController.text =="1" ? Column(
                            children: [
                              Row(
                                children: [
                                  Radio<String>(value: "1", groupValue: _lapDatController.text, onChanged: onChangeLapDatEMCRadio, activeColor: Colors.blue,),
                                  Text("Có lắp đặt trong phòng điện")
                                ],
                              ),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  Radio<String>(value: "0", groupValue: _lapDatController.text, onChanged: onChangeLapDatEMCRadio, activeColor: Colors.blue),
                                  Text("Không lắp đặt trong phòng điện")
                                ],
                              )
                            ],
                          ): SizedBox(width: 10,)),

                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Lịch sử lỗi/cảnh báo", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(width: 10,),
                            Radio<String>(value: "1", groupValue: _baoLoiController.text, onChanged: onChangeLoiRadio, activeColor: Colors.blue,),
                            Text("Có"),
                            SizedBox(width: 2,),
                            Radio<String>(value: "0", groupValue: _baoLoiController.text, onChanged: onChangeLoiRadio, activeColor: Colors.blue),
                            Text("Không"),
                          ],
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 3),
                          child: _baoLoiController.text=="1"? Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 3),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Mã lỗi",
                                  ),
                                ),
                              ),
                              TextFormField(

                                onChanged: (value)=>{
                                  _maLoiController.text = value
                                },
                                controller: _maLoiController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Color(0xff9a9a9a),
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Color(0xff9a9a9a),
                                      )),
                                ),
                              ),
                            ],
                          ):SizedBox(width: 10,)),

                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Thông tin khác",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
                          ),
                        ),
                      ),
                      TextFormField(
                          controller: _thongTinKhacController,
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                            focusedBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                          ),
                          onChanged: (value) {
                            _thongTinKhacController.text = value;
                          }),

                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Kết luận", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(width: 10,),
                            Radio<String>(value: "1", groupValue: _ketLuanController.text, onChanged: onChangeKetLuanRadio, activeColor: Colors.blue,),
                            Text("Đat"),
                            SizedBox(width: 2,),
                            Radio<String>(value: "0", groupValue:  _ketLuanController.text, onChanged: onChangeKetLuanRadio, activeColor: Colors.blue),
                            Text("Không đạt"),
                          ],
                        ),
                      ),
                      TextFormField(
                          controller: _noiDungKetLuanController,
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                            focusedBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                          ),
                          onChanged: (value) {
                            _noiDungKetLuanController.text = value;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Đề xuất", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                            ),
                            ],
                        ),
                      ),
                      TextFormField(
                          controller: _deXuatController,
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                            focusedBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color(0xff9a9a9a),
                                )),
                          ),
                          onChanged: (value) {
                            _deXuatController.text = value;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 3),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("KTV NM/BP", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(

                        onChanged: (value)=>{
                          _KTVNMController.text = value
                        },
                        controller: _KTVNMController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xff9a9a9a),
                              )),
                          focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xff9a9a9a),
                              )),
                        ),
                      ),
                      SizedBox(height: 15,),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Người tạo",
                          ),
                        ),
                      ),
                      Row(

                        children: [
                          Expanded(
                              flex: 1,
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                  disabledBorder: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Color(0xff9a9a9a),
                                      )),
                                ),
                                initialValue: user?.ma_nv ?? "26802",
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 3,
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                  disabledBorder: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Color(0xff9a9a9a),
                                      )),
                                ),
                                initialValue: user?.ho_ten ?? "Nguyễn Chí Thắng",
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      !loaddingsend?

                      CustomElevatedButton(
                          loading: loaddingsend,
                          value: "Sao lưu",
                          onPressed: (){
                            setState(() {
                              loaddingsend = true;
                            });
                              if(_phongDienController.text == ""){
                                ToastMessage.showMessageError(context, "Vui lòng chọn phòng điện!");
                                setState(() {loaddingsend = false;});
                                }
                                else if(_nhietDoController.text == "" ){
                                    ToastMessage.showMessageError(context, "Vui lòng nhập nhiệt độ!");
                                    setState(() {loaddingsend = false;});
                                }else if(_mucDoBuiController.text == "" ){
                                  ToastMessage.showMessageError(context, "Vui lòng chọn mức độ bụi!");
                                  setState(() {loaddingsend = false;});
                                }else if(_doAmController.text == "" ){
                                  ToastMessage.showMessageError(context, "Vui lòng nhập độ ẩm!");
                                  setState(() {loaddingsend = false;});
                                }else if(_mucDoBuiController.text == "" ){
                                  ToastMessage.showMessageError(context, "Vui lòng chọn mức độ ẩm!");
                                  setState(() {loaddingsend = false;});
                                }
                                else if(_heThongLamMatController.text == "1" && _tinhTrangThietBiController.text == ""){
                                  ToastMessage.showMessageError(context, "Vui lòng chọn tình trạng thiết bị!");
                                  setState(() {loaddingsend = false;});
                                }else if(_baoLoiController.text == "1" && _maLoiController.text.trim() == ""){
                                  ToastMessage.showMessageError(context, "Vui lòng nhập mã lỗi!");
                                  setState(() {loaddingsend = false;});
                                }else if(_KTVNMController.text.trim() == ""){
                                  ToastMessage.showMessageError(context, "Vui lòng nhập KTV NM/BP!");
                                  setState(() {loaddingsend = false;});
                                } else{
                                  // ToastMessage.showMessageSuccess(context, "OK");
                                // print(loaddingsend);
                                //
                                  CreateTuanKiemModel newBody = CreateTuanKiemModel(
                                    idDiaDiem: int.parse(_phongDienController.text),
                                    nhietDo: double.parse(_nhietDoController.text.trim()),
                                    mucDoBui: _mucDoBuiController.text,
                                    doAm: double.parse(_doAmController.text.trim()),
                                    danhGiaDoAm: _mucDoAmController.text,
                                    khac: _moiTruongVanHanhKhacController.text.trim(),
                                    heThongLamMat: int.parse(_heThongLamMatController.text),
                                    tinhTrangThietBi: _heThongLamMatController.text=="0"? "": _tinhTrangThietBiController.text,
                                    emcDillters: int.parse(_emcController.text),
                                    lapDatTrongPhongDien: _emcController.text=="0"?0: int.parse(_lapDatController.text),
                                    lichSuLoi: int.parse(_baoLoiController.text),
                                    maLoi: _baoLoiController.text == "0"? "":_maLoiController.text.trim(),
                                    thongTinKhac: _thongTinKhacController.text.trim(),
                                    ketLuan: int.parse(_ketLuanController.text),
                                    noiDungKetLuan: _noiDungKetLuanController.text.trim(),
                                    deXuat: _deXuatController.text.trim(),
                                      ktvTuanKiem: _KTVNMController.text.trim(),
                                    idUser: user?.id,
                                    thoiGianKhoiTao: DateTime.now().toString().split(" ")[0]+"T"+DateTime.now().toString().split(" ")[1]+"Z"
                                      );
                                  GetAction.CreateTuanKiemAction(context, user?.token??"", newBody, onChangeLoaddingSend);
                                  // print(newBody);

                                }


                          },

                          ):
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 64)),
                        ),
                        onPressed: (){},
                        child: CircularProgressIndicator(color: Colors.white,)),
                        SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ));
      }

  }
}
