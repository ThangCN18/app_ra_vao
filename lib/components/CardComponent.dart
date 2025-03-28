import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../models/user_provider.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: false).user;

    return Card(
      color: Color(0xaa008FF6),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 8),
            Text(
              "ỨNG DỤNG RÀ SOÁT NHU CẦU RA VÀO CỔNG",
              style: TextStyle(
                fontFamily: "RobotoBold",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Divider(color: Colors.white70),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage("assets/images/userdefault.png"),
                    height: 50,
                    width: 50,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.ho_ten ?? "Nguyễn Chí Thắng",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "RobotoBold",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user?.ma_nv ?? " ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "RobotoBold",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user?.ca_kip ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "RobotoBold",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user?.bo_phan ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "RobotoBold",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(color: Colors.white70),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Xem thêm",
                style: TextStyle(
                  fontFamily: "RobotoBold",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
