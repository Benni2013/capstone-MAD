import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Colors - Light Theme
abstract class AppColorsLight {
  static const Color primary = Color(0xFF108244);
  static const Color accent = Color.fromARGB(47, 64, 155, 105);
  static const Color text = Color(0xff1F1A3D);
static const Color textSecondary = Color(0xFF677487);
  static const Color placeholder = Color(0xFFE8EAF0);
  static const Color placeholderText = Color(0xFFC6CAD3);
  static const Color background = Color(0xFFD9D9D9);
  static const Color error = Color(0xFFDF1C41);
}

/// App Colors - Dark Theme
abstract class AppColorsDark {
  static const Color primary = Color(0xFFD9D9D9);
  static const Color accent = Color(0xFFc50110);
  static const Color text = Color(0xFFD9D9D9);
  static const Color placeholder = Color(0xFF7681a4);
  static const Color placeholderText = Color(0xFF525C7C);
  static const Color background = Color(0xFF2D3251);
  static const Color error = Color(0xFFD0524A);
}

/// Common Colors
abstract class AppColors {
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color gray = Color(0xFF8D989D);
  static const Color grayScale = Color(0xFF0D0D12);
  static const Color grayScale400 = Color(0xFF818898);
  static const Color grayScale100 = Color(0xFFDFE1E7);

}

/// Border Radius Constants
abstract class AppRadius {
  static final Radius standard = Radius.circular(10.r);
  static final Radius small = Radius.circular(5.r);
  static final Radius large = Radius.circular(15.r);
  
  static final BorderRadius circular = BorderRadius.circular(10.r);
  static final BorderRadius circularSmall = BorderRadius.circular(5.r);
  static final BorderRadius circularLarge = BorderRadius.circular(15.r);
  
  static final BorderRadius all = BorderRadius.all(standard);
  static final BorderRadius allSmall = BorderRadius.all(small);
  
  static final BorderRadius topOnly = BorderRadius.only(
    topLeft: standard,
    topRight: standard,
  );
  
  static final BorderRadius bottomOnly = BorderRadius.only(
    bottomLeft: standard,
    bottomRight: standard,
  );
}

/// Border Styles
abstract class AppBorders {
  static const BorderSide transparent = BorderSide(
    color: Colors.transparent,
    width: 0,
  );
  
  /// Input TextField Border
  static final OutlineInputBorder input = OutlineInputBorder(
    borderRadius: AppRadius.circular,
    borderSide: transparent,
  );
  
  /// Card Border
  static final RoundedRectangleBorder card = RoundedRectangleBorder(
    borderRadius: AppRadius.all,
    side: transparent,
  );
  
  /// Circle Border
  static const CircleBorder circle = CircleBorder(side: transparent);

}

/// Padding Constants
abstract class AppPadding {
  /// Standard page/screen horizontal padding
  static final EdgeInsets page = EdgeInsets.symmetric(horizontal: 20.w);
  
  /// Input field vertical padding
  static final EdgeInsets inputVertical = EdgeInsets.symmetric(vertical: 20.h);
  
  /// Button padding
  static final EdgeInsets button = EdgeInsets.symmetric(vertical: 18.h);
  
  /// Card padding
  static final EdgeInsets card = REdgeInsets.all(10.0);
  
  /// General padding values
  static final EdgeInsets all8 = REdgeInsets.all(8.0);
  static final EdgeInsets all16 = REdgeInsets.all(16.0);
  static final EdgeInsets all24 = REdgeInsets.all(24.0);
}

/// Spacing Constants
abstract class AppSpacing {
  static final SizedBox xs = SizedBox(height: 5.h);
  static final SizedBox sm = SizedBox(height: 10.h);
  static final SizedBox md = SizedBox(height: 20.h);
  static final SizedBox lg = SizedBox(height: 40.h);
  static final SizedBox xl = SizedBox(height: 60.h);
  
  /// Horizontal spacing
  static final SizedBox horizontalXs = SizedBox(width: 5.w);
  static final SizedBox horizontalSm = SizedBox(width: 10.w);
  static final SizedBox horizontalMd = SizedBox(width: 20.w);
  static final SizedBox horizontalLg = SizedBox(width: 40.w);
}

/// Text Styles
abstract class AppTextStyles {
  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle whiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  
  static const TextStyle semiBold = TextStyle(
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle medium = TextStyle(
    fontWeight: FontWeight.w500,
  );
}

/// Duration Constants (for animations)
abstract class AppDurations {
  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);
}

/// Animation Curves
abstract class AppCurves {
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
}