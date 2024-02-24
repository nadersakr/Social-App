
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TapButton extends StatelessWidget {
  final Icon icon;
  final Widget widget;
  const TapButton({
    super.key,
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
    );
  }
}