import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class OnBoardingIndicator extends StatelessWidget {
  final double marginEnd;
  final bool selected;

  OnBoardingIndicator({
    required this.selected,
    this.marginEnd = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsetsDirectional.only(end: marginEnd),
    );
  }
}
