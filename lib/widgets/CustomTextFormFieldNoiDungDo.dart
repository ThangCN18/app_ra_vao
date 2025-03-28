import 'package:flutter/material.dart';

class CustomTextFormFieldNoiDungDo extends StatefulWidget {
  const CustomTextFormFieldNoiDungDo({super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController? controller;

  @override
  State<CustomTextFormFieldNoiDungDo> createState() => _CustomTextFormFieldNoiDungDoState();
}

class _CustomTextFormFieldNoiDungDoState extends State<CustomTextFormFieldNoiDungDo> {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: TextStyle(fontSize: 10),),

          TextFormField(

            keyboardType: TextInputType.number,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xff9a9a9a)),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xff9a9a9a)),
              ),
            ),
            onChanged: (value) {
              if(widget.controller != null) {
                widget.controller?.text = value;
              }
            },
          ),
        ],
      ),
    );
  }
}
