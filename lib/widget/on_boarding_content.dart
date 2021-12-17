import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingContent extends StatelessWidget {
  String? imagepath;
  String? title;
  String? subtitle;

  OnBoardingContent({this.imagepath, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Text(title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold)),
        Text(subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.grey)),
        SizedBox(
          height: 50.h,
        ),
        Image.asset(imagepath!, height: 350,width: double.infinity,fit: BoxFit.fill,)
      ],
    );
  }
}
