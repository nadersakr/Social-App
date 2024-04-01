import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TSized {
static EdgeInsets get paddingAll => EdgeInsets.all(10.w);

static const double small = 10;
static const double medium = 20;
static const double large = 30;

static double get smallSize => small.w;
static double get mediumSize => medium.w;
static double get largeSize => large.w;
static double get extraLargeSize => 40.w;
static double get extraSmallSize => 5.w;
static double get extraExtraLargeSize => 50.w;
static double get extraExtraSmallSize => 2.w;
static double get extraExtraExtraLargeSize => 60.w;
static double get extraExtraExtraSmallSize => 3.w;



static EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: 10.w);
static EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: 10.w);
static EdgeInsets get paddingH10 => EdgeInsets.symmetric(horizontal: 10.w);
static EdgeInsets get paddingV10 => EdgeInsets.symmetric(vertical: 10.w);
}
