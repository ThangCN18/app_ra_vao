import 'package:flutter/material.dart';

class FlexibleRow extends StatelessWidget {
  final List<Widget> children;
  final int maxItemsPerRow;

  FlexibleRow({required this.children, this.maxItemsPerRow = 2});

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    List<Widget> currentRowChildren = [];

    // Tạo các hàng với số lượng tối đa là maxItemsPerRow
    for (int i = 0; i < children.length; i++) {
      currentRowChildren.add(children[i]);
      if (currentRowChildren.length == maxItemsPerRow || i == children.length - 1) {
        rows.add(Row(children: currentRowChildren));
        currentRowChildren = [];
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }
}
