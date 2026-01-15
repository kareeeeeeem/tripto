import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/l10n/app_localizations.dart';


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
      displayText = '${widget.text.substring(0, 40).trimRight()}...';
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
              style: GoogleFonts.markaziText(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            TextSpan(
              text: isExpanded ?
              AppLocalizations.of(context)!.less :
              AppLocalizations.of(context)!.more,
              style:  GoogleFonts.markaziText(
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
