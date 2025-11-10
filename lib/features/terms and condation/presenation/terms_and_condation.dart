import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:non_stop/constants/assets.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: "الشروط والاحكام"),
              SizedBox(height: 20.h),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  Assets.resourcePngsGym,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.h),

              // Intro Text
              Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: EdgeInsets.only(bottom: 16.h, right: 20.w, left: 20.w),

                child: Text(
                  'مرحباً بك في نادي Non-stop، باستخدامك لمرافق النادي، فإنك توافق على الشروط التالية:',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    color: Colors.white,
                    fontSize: 16.sp,
                    height: 1.6,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Terms List
              BuildTermIcon(
                '1. الاشتراك والاستخدام',
                'العضوية شخصية ولا يمكن تحويلها أو مشاركتها، ويمنع دخول غير المشتركين دون إذن مسبق.',
              ),
              BuildTermIcon(
                '2. السلوك داخل النادي',
                'يجب احترام خصوصية الآخرين والتعامل بأدب مع الموظفين والأعضاء.',
              ),
              BuildTermIcon(
                '3. استخدام المرافق',
                'هناك قاعات ومناطق مخصصة للرجال وأخرى للنساء، فضلًا الالتزام بها.',
              ),
              BuildTermIcon(
                '4. المواعيد',
                'يُرجى الالتزام بالمواعيد المحددة للتمارين أو الجلسات.',
              ),
              BuildTermIcon(
                '5. السلامة',
                'يُمنع إساءة استخدام الأجهزة أو المعدات، ويجب الإبلاغ عن أي أعطال.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // }
}

class BuildTermIcon extends StatelessWidget {
  final String title;
  final String description;

  const BuildTermIcon(this.title, this.description, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, right: 20.w, left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              color: Colors.white70,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
