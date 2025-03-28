import "package:flutter/material.dart";
import "package:ra_soat_ra_vao/models/dropdown_value_model.dart";

class CustomDropdownButtonFormField extends StatefulWidget {
  const CustomDropdownButtonFormField({super.key, required this.items, required this.hintTextValue,required this.changeValue, required this.textValue});
  final List<DropdownValue> items;
  final String hintTextValue;
  final String textValue;
  final void Function(String)  changeValue;


  @override
  State<CustomDropdownButtonFormField> createState() => _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState extends State<CustomDropdownButtonFormField> {


  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<dynamic>> itemsdrop = widget.items.map((item) => DropdownMenuItem<dynamic>(
      child: Text(item.title),
      value: item.value,
    )).toList();

    return DropdownButtonFormField(
      items: itemsdrop,
      value: widget.textValue==""?null:widget.textValue,
      onChanged: (value){

        print(value);
        widget.changeValue(value);
      },
      validator: (value){
        if (value == "" || value.isEmpty) {
          return "Vui lòng" + widget.hintTextValue.toLowerCase();
        }
        return null;
      },

      decoration: InputDecoration(
          hintText: widget.hintTextValue,
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Color(0xff9a9a9a),)
          ),
          enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Color(0xff9a9a9a),)
          ),
          focusedBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Color(0xff194689),)
          )
      ),
    );
  }
}
