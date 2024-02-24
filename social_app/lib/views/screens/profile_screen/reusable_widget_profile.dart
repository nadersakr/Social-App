import 'package:flutter/material.dart';

Widget customNameBar(
    {required String name,
    required BuildContext context,
    required void Function()? onpress}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: Row(
      children: [
        GestureDetector(
          onTap: onpress,
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.058,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              children: [
                const SizedBox(
                  width: 32,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: IconButton(
                      onPressed: onpress,
                      iconSize: 20,
                      color: Colors.white,
                      icon: const Icon(
                          Icons.arrow_forward_ios) // Adjust icon size if needed
                      ),
                ), // Removed Center and IconButton
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}

Widget defaultTextFormField({
  IconData? prefixIcon,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmitted,
  void Function(String)? onChanged,
  void Function()? onTap,
  String? Function(String?)? validate,
  IconData? suffixIcon,
  bool isPassword = false,
  void Function()? suffixPressed,
  required String label,
}) =>
    TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: suffixPressed,
                )
              : null,
        ),
        validator: validate);
