import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/network/api_service.dart';
import 'package:mad_final_project/utils/constants.dart';

class ApiIntegrationPage extends StatefulWidget {
  const ApiIntegrationPage({super.key});

  @override
  State<ApiIntegrationPage> createState() => _ApiIntegrationPageState();
}

class _ApiIntegrationPageState extends State<ApiIntegrationPage> {
  bool isLoading = false;
  List<dynamic> apiData = [];
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await ApiService().fetchData();
      setState(() {
        apiData = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColorsLight.primary,
        title: Text(
          'External API Data',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColorsLight.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading data...',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            : error != null
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Error loading data',
                            style: GoogleFonts.manrope(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.grayScale,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            error!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton(
                            onPressed: _fetchData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColorsLight.primary,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.w,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Retry',
                              style: GoogleFonts.manrope(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : apiData.isEmpty
                    ? Center(
                        child: Text(
                          'No data available',
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: apiData.length,
                        itemBuilder: (context, index) {
                          final item = apiData[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 16.h),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: AppColorsLight.primary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${item['id']}',
                                            style: GoogleFonts.manrope(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColorsLight.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['title'] ?? 'No Title',
                                              style: GoogleFonts.manrope(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.grayScale,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              'User ID: ${item['userId']}',
                                              style: GoogleFonts.manrope(
                                                fontSize: 12.sp,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (item['body'] != null) ...[
                                    SizedBox(height: 12.h),
                                    Text(
                                      item['body'],
                                      style: GoogleFonts.manrope(
                                        fontSize: 14.sp,
                                        color: Colors.grey[700],
                                        height: 1.5,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
