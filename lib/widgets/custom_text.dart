import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final List <Shadow>? shadow;
  final Color? color;
  final String text;
  final double fontSize;
  const CustomText({super.key,  this.shadow, required this.text, required this.fontSize,  this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        text,
        style:  GoogleFonts.rubik(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: shadow ?? [
            const Shadow(color: Colors.blueAccent,
            blurRadius: 4)
          ],
          color: color ?? Colors.black87

        ),

      ),
    );
  }
}
