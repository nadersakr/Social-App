import 'package:flutter/material.dart';
import 'package:social_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
 final String hintText;
 final int? maxline;
 final Widget? suffixIcon;
 final bool? obscureText;
 final TextInputType? keyboardType;
 final String? Function(String?)? validator;
 final TextEditingController? controller;
 const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.maxline,
 });

 @override
 Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        filled: true,
        fillColor: AppColors.lightGray,
        hintText: hintText,
        suffixIcon: suffixIcon,
        
      ),
      validator: validator,
      maxLines: obscureText != null && obscureText! ? 1 : maxline,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
    );
 }
}