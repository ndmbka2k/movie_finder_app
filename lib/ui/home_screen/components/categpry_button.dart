import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 69.w,
      padding: EdgeInsets.only(top: 26.h, bottom: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          width: 1,
          color: Color(0x4cffffff),
        ),
        gradient: LinearGradient(colors: [
          Color(0x4ca6a1e0),
          Color(0x4ca1f3fe),
        ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(image),
          Text(
            title,
            style: TextStyle(
              fontSize: 9.sp,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );
  }
}
