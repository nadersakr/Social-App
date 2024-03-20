import 'package:flutter/material.dart';
import 'package:social_app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final void Function()? onPressed;
 final double? height;
 final double? width;
 final Color? backgroundColors;
  const CustomButton({
    super.key,
    this.buttonText,
    this.onPressed,
    this.height,
    this.width,
    this.backgroundColors
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width ??  double.infinity,
      height:height ?? 55,
      decoration: BoxDecoration(
        gradient:backgroundColors!=null ? null : LinearGradient(
          colors: [AppColors.blue, AppColors.blue.withOpacity(0.5)],
        ),
        borderRadius: BorderRadius.circular(30),
      color:backgroundColors ?? backgroundColors,
      ),
      child: TextButton(
        onPressed:  onPressed,
        child: Text(
          textAlign: TextAlign.center,
          buttonText ?? "Button",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
