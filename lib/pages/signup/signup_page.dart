import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mad_final_project/network/auth_service.dart';
import 'package:mad_final_project/utils/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  String _phoneNumber = '';
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      if (_phoneNumber.isEmpty) {
        setState(() {
          _errorMessage = 'Please enter a valid phone number';
          _isLoading = false;
        });
        return;
      }

      try {
        // Call API with email and password (API only accepts these 2 fields)
        final result = await _authService.signup(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        setState(() {
          _isLoading = false;
        });

        if (result['success'] == true) {
          // Show success message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        result['message'] ?? 'Account created successfully!',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            // Navigate to login page
            Navigator.pushReplacementNamed(context, 'login');
          }
        } else {
          setState(() {
            _errorMessage = result['message'] ?? 'Signup failed. Please try again.';
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'An unexpected error occurred: $e';
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
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
                  "Create Your Account",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.manrope(
                    color: AppColors.grayScale,
                    textStyle: AppTextStyles.bold,
                    fontSize: 24.sp,
                  ),
                ),
                AppSpacing.xs,
                Text(
                  "Register to explore amazing real estate properties.",
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
                  "Full Name",
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
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: AppRadius.circular),
                      hintText: "Enter your name",
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
                  "Phone Number",
                  style: GoogleFonts.manrope(
                    color: AppColors.grayScale,
                    textStyle: AppTextStyles.medium,
                    fontSize: 14.sp,
                  ),
                ),
                AppSpacing.xs,
                SizedBox(
                  height: 48.h,
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(borderRadius: AppRadius.circular),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.circular,
                        borderSide: BorderSide(color: AppColorsLight.accent),
                      ),
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                    ),
                    initialCountryCode: 'ID',
                    dropdownIconPosition: IconPosition.trailing,
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.grayScale,
                    ),
                    flagsButtonPadding: EdgeInsets.only(left: 12.w),
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grayScale,
                    ),
                    dropdownTextStyle: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grayScale,
                    ),
                    onChanged: (phone) {
                      setState(() {
                        _phoneNumber = phone.completeNumber;
                      });
                    },
                  ),
                ),

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
                      border: OutlineInputBorder(borderRadius: AppRadius.circular),
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
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: AppRadius.circular),
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

                AppSpacing.xl,
                Container(
                  width: double.infinity,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppColorsLight.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: _isLoading ? null : _handleSignup,
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            "Sign Up",
                            style: GoogleFonts.manrope(
                              textStyle: AppTextStyles.semiBold,
                              fontSize: 16.sp,
                              color: AppColors.white,
                            ),
                          ),
                  ),
                ),
                AppSpacing.md,
                AppSpacing.xs,
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "By registering you agree to",
                          style: GoogleFonts.manrope(
                            textStyle: AppTextStyles.semiBold,
                            color: AppColorsLight.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: "\nTerms & Conditions ",
                          style: GoogleFonts.manrope(
                            textStyle: AppTextStyles.semiBold,
                            color: AppColorsLight.primary,
                          ),
                        ),
                        TextSpan(
                          text: "and",
                          style: GoogleFonts.manrope(
                            textStyle: AppTextStyles.semiBold,
                            color: AppColorsLight.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: " Privacy Policy",
                          style: GoogleFonts.manrope(
                            textStyle: AppTextStyles.semiBold,
                            color: AppColorsLight.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.sm,
                AppSpacing.xs,
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.grayScale400,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        " Sign In",
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
