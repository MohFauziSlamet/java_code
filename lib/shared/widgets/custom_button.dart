import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';

class ButtonComponents extends StatelessWidget {
  const ButtonComponents({Key? key, this.buttonTitle, this.iconPath, this.buttonColor, this.textColor}) : super(key: key);
  final String? buttonTitle;
  final String? iconPath;
  final Color? buttonColor;
  final Color? textColor;
  // final ColorConst colorConst = ColorConst();
  // final AssetsConst assetsConst = AssetsConst();
  // @override
  @override
  Widget build(BuildContext context) {
    return iconPath != null
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 20,
                      child: SvgPicture.asset(iconPath ?? AssetConts.svgGoogleIcon),
                    ),
                  ),
                ),
                Text(
                  buttonTitle ?? "Title",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: textColor ?? Colours.darkBlack, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 44,
            decoration: BoxDecoration(
              color: buttonColor ?? Colours.green2,
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: Text(
              buttonTitle ?? "Title",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
