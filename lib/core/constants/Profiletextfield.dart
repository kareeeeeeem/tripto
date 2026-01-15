import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

enum FieldType { name, email, phone, password }

class Profiletextfield extends StatefulWidget {
  final String label;
  final bool isReadOnly;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FieldType fieldType;

  const Profiletextfield({
    super.key,
    required this.label,
    required this.isReadOnly,
    required this.controller,
    this.focusNode,
    required this.fieldType,
  });

  @override
  State<Profiletextfield> createState() => _textfieldState();
}

class _textfieldState extends State<Profiletextfield> {
  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType = TextInputType.text;
    List<TextInputFormatter> inputFormatters = [];

    switch (widget.fieldType) {
      case FieldType.name:
        keyboardType = TextInputType.name;
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zء-ي\s]')),
        ]; // يقبل حروف ومسافات
        break;
      case FieldType.email:
        keyboardType = TextInputType.emailAddress;
        inputFormatters = []; // أي نص مسموح للبريد
        break;
      case FieldType.phone:
        keyboardType = TextInputType.phone;
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(12),
        ]; // أرقام فقط بحد أقصى 11 رقم
        break;
      case FieldType.password:
        keyboardType = TextInputType.text;
        inputFormatters = [];
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            readOnly: widget.isReadOnly,
            focusNode: widget.focusNode,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: widget.fieldType == FieldType.password,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: GoogleFonts.markaziText(
                color: Colors.grey,
                fontSize: 18,
              ),
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
