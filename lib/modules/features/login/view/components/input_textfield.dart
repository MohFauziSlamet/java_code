import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code/modules/features/login/controllers/login_controler.dart';
import '/constant/core/assets_const.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  InputTextField({
    Key? key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    this.isObscuretext = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.formKey,
  }) : super(key: key);

  String hintText;
  bool isPassword = false;
  bool isObscuretext;
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;
  Key? formKey;

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 46.sp),
      child: Form(
        key: formKey,
        child: TextFormField(
          autocorrect: false,
          obscureText: isObscuretext,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff009AAD),
              ),
            ),
            suffixIcon: isPassword
                ? InkWell(
                    onTap: () {
                      LoginController.to.isHidden.toggle();
                    },
                    child: SizedBox(
                      height: 17.h,
                      child: LoginController.to.isHidden.isTrue
                          ? Image.asset(AssetConts.iconEyeHidden)
                          : const Icon(Icons.remove_red_eye_outlined),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
