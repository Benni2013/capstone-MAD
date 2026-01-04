import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      // Simulate login validation
      if (_emailController.text != 'user@example.com' || _passwordController.text != 'password123') {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
        return;
      }

      // Success - navigate to home
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.all24,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.lg,
                Text(
                  "Welcome Back!",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.manrope(
                    color: AppColors.grayScale,
                    textStyle: AppTextStyles.bold,
                    fontSize: 24.sp,
                  ),
                ),
                AppSpacing.xs,
                Text(
                  "Sign in to continue exploring amazing properties.",
                  style: GoogleFonts.manrope(
                    color: AppColors.grayScale400,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                if (_errorMessage != null) ...[
                  AppSpacing.md,
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: GoogleFonts.manrope(
                              color: Colors.red.shade700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                AppSpacing.md,
                Text(
                  "Email",
                  style: GoogleFonts.manrope(
                    color: AppColors.grayScale,
                    textStyle: AppTextStyles.medium,
                    fontSize: 14.sp,
                  ),
                ),
                AppSpacing.xs,
                SizedBox(
                  height: 48.h,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                      ),
                      hintText: "Enter your Email",
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: AppColorsLight.accent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                AppSpacing.md,
                Text(
                  "Password",
                  style: GoogleFonts.manrope(
                    color: AppColors.grayScale,
                    textStyle: AppTextStyles.medium,
                    fontSize: 14.sp,
                  ),
                ),
                AppSpacing.xs,
                SizedBox(
                  height: 48.h,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                      ),
                      hintText: "Enter your Password",
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: AppColorsLight.accent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacing.sm,
                AppSpacing.xs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      textAlign: TextAlign.end,
                      style: GoogleFonts.manrope(
                        color: AppColorsLight.error,
                        textStyle: AppTextStyles.semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                AppSpacing.lg,
                Container(
                  width: double.infinity,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppColorsLight.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: _handleLogin,
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.manrope(
                        textStyle: AppTextStyles.semiBold,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Image.asset(
                            "assets/images/google.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSm,
                    AppSpacing.horizontalXs,
                    Container(
                      width: 56.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Image.asset(
                            "assets/images/apple.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSm,
                    AppSpacing.horizontalXs,
                    Container(
                      width: 56.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Image.asset(
                            "assets/images/facebook.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.grayScale400,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'signup');
                      },
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
                AppSpacing.md,
              ],
            ),
          ),
        ),
      ),
    );
  }
}