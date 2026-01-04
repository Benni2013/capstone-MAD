import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/utils/constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2,),
            Text("Luxeyline", style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w600,
              fontSize: 40.sp,
              color: AppColors.white
            ),),
            Spacer(flex: 2,),
            Text("Version 1.0.0",
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white
            ),),
            AppSpacing.md,
          ],
        ),
      ),
    );
  }
}