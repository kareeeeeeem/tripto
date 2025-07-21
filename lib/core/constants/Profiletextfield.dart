import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profiletextfield extends StatefulWidget {
  final String label;
  final bool isReadOnly;
  final TextEditingController controller;



  const Profiletextfield({
    super.key,
    required this.label,
    required this.isReadOnly, required this.controller,
  });

  @override
  State<Profiletextfield> createState() => _textfieldState();
}

class _textfieldState extends State<Profiletextfield> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            cursorColor: Colors.black,
            controller: widget.controller,
            readOnly: widget.isReadOnly,
            keyboardType: TextInputType.text,
            obscureText: widget.label == "Password" ? true : false,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle:  GoogleFonts.markaziText(color: Colors.grey, fontSize: 18),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 1),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}