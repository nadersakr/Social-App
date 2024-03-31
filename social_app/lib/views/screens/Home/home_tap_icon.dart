import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TapButton extends StatelessWidget {
  final Icon icon;
  final isHomePage;
  final Widget widget;
  const TapButton({
    super.key,
    this.isHomePage = false,
    required this.icon,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: SizedBox(
          height: 40.h,
          child: Center(
            child: icon,
          ),
        ),
        onTap: () {
          if (isHomePage) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => widget),
                (route) => false);
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => widget));
          }
        });
  }
}
