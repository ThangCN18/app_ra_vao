import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({Key? key, required this.name, required this.value_validator, required this.bool_obscureText, required this.textController});
  final String name;
  final String value_validator;
  final bool bool_obscureText;
  final TextEditingController textController;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _value_bool_obscureText;

  @override
  void initState() {
    super.initState();
    _value_bool_obscureText = widget.bool_obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.textController,
          obscureText: _value_bool_obscureText ?? false,
          obscuringCharacter: "*",

          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.value_validator;
            }
            return null;
          },
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 18),
          onChanged: (value) {
            // Update the value of the controller
            widget.textController.text = value;
          },
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.name,

              hintStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 18),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1, color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
              errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 16)),
        ),
        if (widget.bool_obscureText)
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _value_bool_obscureText = !_value_bool_obscureText;
                });
              },
              icon: _value_bool_obscureText ? FaIcon(FontAwesomeIcons.eyeSlash, size: 20,) : FaIcon(FontAwesomeIcons.eye, size: 20,),
            ),
          )
      ],
    );
  }
}