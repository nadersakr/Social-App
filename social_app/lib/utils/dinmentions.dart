import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimention{
  static double getWidth(double width, double screenWidth){
    return (width / 375.0) * screenWidth;
  }

  static double getHeight(double height, double screenHeight){
    return (height / 812.0) * screenHeight;
  }


  // heigts
 static double heightScreen_20 = 20.0.h;
  static double heightSpace_150 = 150.h; 
  static double smallHeightSpace_30 = 30.h; 
  
  
  
  
  
  // font sizes 
  static double smallFont = 14.sp; 
}