import 'package:flutter/material.dart';

class Profiletextfield extends StatelessWidget {
  final String label;
  final VoidCallback onEdit;


  const Profiletextfield({
    super.key,
    required this.label,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: label == "Password" ? true : false,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              suffixIcon: TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.mode_edit_outlined),
                label: const Text(
                  "_Edit",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
