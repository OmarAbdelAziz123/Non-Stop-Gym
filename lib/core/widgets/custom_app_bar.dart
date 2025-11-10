import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool hasLeading;

  const CustomAppBar({super.key, required this.title, this.hasLeading = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(159, 90, 91, 0.51),
            Color.fromRGBO(57, 32, 33, 0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (hasLeading)
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
              ),

            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: SvgPicture.asset(
                  "assets/svgs/Notification.svg",
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
