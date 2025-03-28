import "package:flutter/material.dart";
import "package:ra_soat_ra_vao/models/dropdown_value_model.dart";

class CustomDropdownButtonFormField extends StatefulWidget {
  const CustomDropdownButtonFormField({super.key, required this.items, required this.hintTextValue, required this.changeValue, required this.textValue, this.textLongbool = false});
  final List<DropdownValue> items;
  final String hintTextValue;
  final String textValue;
  final void Function(String) changeValue;
  final bool textLongbool;

  @override
  State<CustomDropdownButtonFormField> createState() => _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState extends State<CustomDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<dynamic>> itemsdrop = widget.items
        .map((item) => DropdownMenuItem<dynamic>(
              child: Container( child: Text(item.title, style: TextStyle(),)),
              value: item.value,
            ))
        .toList();

    return DropdownButtonFormField(

      items: itemsdrop,
      value: widget.textValue == "" ? null : widget.textValue,
      onChanged: (value) {
        print(value);
        widget.changeValue(value);
      },
      validator: (value) {
        if (value == "" || value.isEmpty) {
          return "Vui lòng" + widget.hintTextValue.toLowerCase();
        }
        return null;
      },
      selectedItemBuilder: (context) => widget.items
          .map((item) => DropdownMenuItem<dynamic>(
        child: widget.textLongbool? Container( width: MediaQuery.of(context).size.width - 100, child: Text(item.title, style: TextStyle( overflow: TextOverflow.ellipsis,),)):Container(  child: Text(item.title, style: TextStyle( overflow: TextOverflow.ellipsis,),)),
        value: item.value,
      ))
          .toList(),

      decoration: InputDecoration(
          hintText: widget.hintTextValue,
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xff9a9a9a),
              )),
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
                color: Color(0xff194689),
              ))),
    );
  }
}
