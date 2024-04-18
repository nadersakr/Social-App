import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? maxline;
  final int? maxlenght;
  final double? width;
  final double? height;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChangeValidator;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.maxline,
    this.width,
    this.height,
    this.maxlenght,
    this.onChangeValidator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 1.sw,
      height: height ?? 0.09.sh,
      child: TextFormField(
        maxLength: maxlenght ?? 50,
        controller: controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          filled: true,
          fillColor: AppColors.lightGray,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: 12.sp,
          ),
          suffixIcon: suffixIcon,
        ),
        autovalidateMode: autovalidateMode,
        validator: validator,
        maxLines: obscureText != null && obscureText! ? 1 : maxline,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
      ),
    );
  }
}
