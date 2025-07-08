import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandedText({
    super.key,
    required this.text,
    this.maxLines = 2,
  });

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // لو مش expanded هنقص الكلام
    String displayText = widget.text;

    if (!isExpanded && widget.text.length > 40) {
      displayText = widget.text.substring(0, 40).trimRight() + '...';
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: displayText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            TextSpan(
              text: isExpanded ? ' Less' : ' More...',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              // recognizer: TapGestureRecognizer()
              //   ..onTap = () {
              //     setState(() {
              //       isExpanded = !isExpanded;
              //     });
              //   },
            ),
          ],
        ),
      ),
    );
  }
}
