import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SlidePage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const SlidePage(
      {super.key,
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.sp,
        right: 20.sp,
        top: 30.sp,
        bottom: 130.sp,
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 340.w,
            height: 232.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xEE222831),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xEE727C8D),
            ),
          ),
        ],
      ),
    );
  }
}
