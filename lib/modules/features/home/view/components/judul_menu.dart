import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/config/themes/colours.dart';

// ignore: must_be_immutable
class JudulMenu extends StatelessWidget {
  JudulMenu({
    Key? key,
    required this.iconMenu,
    required this.judulMenu,
  }) : super(key: key);

  String iconMenu;
  String judulMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      margin: const EdgeInsets.only(bottom: 17),
      child: Row(
        children: [
          SizedBox(
            width: 19,
            height: 17,
            child: Image.asset(
              iconMenu,
              fit: BoxFit.cover,
              color: Colours.green2,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            judulMenu,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colours.green2,
            ),
          )
        ],
      ),
    );
  }
}
