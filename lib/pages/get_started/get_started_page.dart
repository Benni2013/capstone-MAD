import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/utils/constants.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppSpacing.xl,
          Icon(Icons.info, size: 60),
          AppSpacing.sm,
          Text(
            "Get Started",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
              color: AppColors.grayScale,
            ),
          ),
          AppSpacing.xs,
          Text(
            "Welcome! Let’s dive in into account.",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.grayScale400,
            ),
          ),
          AppSpacing.xl,
          Container(
            margin: AppPadding.page,
            padding: AppPadding.all16.copyWith(top: 12, bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grayScale100),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50.h,
            child: Row(
              children: [
                Image.asset(
                      "assets/images/google.png",
                      width: 24.w,
                      height: 24.h,
                    ),
                Spacer(),
                Text(
                  "Sign in with Google",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.grayScale,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          AppSpacing.sm,
          AppSpacing.xs,
          Container(
            margin: AppPadding.page,
            padding: AppPadding.all16.copyWith(top: 12, bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grayScale100),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50.h,
            child: Row(
              children: [
                Image.asset(
                      "assets/images/apple.png",
                      width: 24.w,
                      height: 24.h,
                    ),
                Spacer(),
                Text(
                  "Sign in with Apple",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.grayScale,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          AppSpacing.sm,
          AppSpacing.xs,
          Container(
            margin: AppPadding.page,
            padding: AppPadding.all16.copyWith(top: 12, bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grayScale100),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50.h,
            child: Row(
              children: [
               Image.asset(
                      "assets/images/facebook.png",
                      width: 24.w,
                      height: 24.h,
                    ),
                Spacer(),
                Text(
                  "Sign in with Facebook",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.grayScale,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
      
          AppSpacing.sm,
          AppSpacing.xs,
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Or continue with',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
            ],
          ),
          AppSpacing.sm,
          AppSpacing.xs,
          Container(
            margin: AppPadding.page,
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColorsLight.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                padding: AppPadding.all16.copyWith(top: 8, bottom: 8),
              ),
              onPressed: () {},
              child: Text(
                "Sign in with Email",
                style: GoogleFonts.manrope(
                  textStyle: AppTextStyles.semiBold,
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.grayScale400,
                  ),
                ),
                InkWell(onTap: (){},
                  child: Text(
                    " Sign Up",
                    style: GoogleFonts.manrope(
                     textStyle: AppTextStyles.semiBold,
                      fontSize: 14.sp,
                      color: AppColorsLight.primary,
                    ),
                  ),
                ),
              ],
          ),
          AppSpacing.lg,
        ],
      ),
    );
  }
}
