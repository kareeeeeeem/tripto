import 'package:flutter/material.dart';

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
            controller: widget.controller,
            readOnly: widget.isReadOnly,
            keyboardType: TextInputType.text,
            obscureText: widget.label == "Password" ? true : false,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),

            ),
          ),
        ),
      ],
    );
  }
}