import 'package:flutter/material.dart';

class RowDeviceComponent extends StatelessWidget {
  const RowDeviceComponent({super.key, required this.px, required this.ctb, required this.tb, required this.lk});
  final int px;
  final int ctb;
  final int tb;
  final int lk;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/phanxuong.png"), height: 40, width:40,),
              SizedBox(height: 2,),
              Text(px.toString(), style: TextStyle(fontSize: 18, fontFamily: "RobotoBold"),),
              Text("Phân xưởng", style: TextStyle(fontSize: 10),),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/cumthietbi.png"), height: 40, width:40,),
              SizedBox(height: 2,),
              Text(ctb.toString(), style: TextStyle(fontSize: 18, fontFamily: "RobotoBold"),),
              Text("Cụm thiết bị", style: TextStyle(fontSize: 10),),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/thietbi.png"), height: 40, width:40,),
              SizedBox(height: 2,),
              Text(tb.toString(), style: TextStyle(fontSize: 18, fontFamily: "RobotoBold"),),
              Text("Thiết bị", style: TextStyle(fontSize: 10),),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/linhkien.png"), height: 40, width:40,),
              SizedBox(height: 2,),
              Text(lk.toString(), style: TextStyle(fontSize: 18, fontFamily: "RobotoBold"),),
              Text("Linh kiện", style: TextStyle(fontSize: 10),),
            ],
          ),
        )
      ],
    );
  }
}
