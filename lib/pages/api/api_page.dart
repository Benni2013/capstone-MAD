import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/network/api_service.dart';
import 'package:mad_final_project/network/auth_service.dart';
import 'package:mad_final_project/utils/constants.dart';

class ApiIntegrationPage extends StatefulWidget {
  const ApiIntegrationPage({super.key});

  @override
  State<ApiIntegrationPage> createState() => _ApiIntegrationPageState();
}

class _ApiIntegrationPageState extends State<ApiIntegrationPage> {
  bool isLoading = false;
  bool isLoadingHealth = false;
  List<dynamic> apiData = [];
  Map<String, dynamic>? healthData;
  String? error;
  String? healthError;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _checkHealth();
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

  Future<void> _checkHealth() async {
    setState(() {
      isLoadingHealth = true;
      healthError = null;
    });

    try {
      final result = await AuthService().checkHealth();
      setState(() {
        if (result['success'] == true) {
          healthData = result['data'];
        } else {
          healthError = result['message'];
        }
        isLoadingHealth = false;
      });
    } catch (e) {
      setState(() {
        healthError = e.toString();
        isLoadingHealth = false;
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
        onRefresh: () async {
          await _fetchData();
          await _checkHealth();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // API Health Status Card
              Container(
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: healthData != null ? Colors.green[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: healthData != null ? Colors.green : Colors.orange,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          color: healthData != null ? Colors.green : Colors.orange,
                          size: 24,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'API Health Status',
                          style: GoogleFonts.manrope(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grayScale,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if (isLoadingHealth)
                      Center(child: CircularProgressIndicator())
                    else if (healthError != null)
                      Text(
                        'Error: $healthError',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),
                      )
                    else if (healthData != null) ...[
                      _buildHealthInfo('Status', healthData!['status'] ?? 'N/A'),
                      SizedBox(height: 8.h),
                      _buildHealthInfo('Timestamp', healthData!['timestamp'] ?? 'N/A'),
                      SizedBox(height: 8.h),
                      _buildHealthInfo(
                        'Uptime',
                        '${((healthData!['uptimeMs'] ?? 0) / 1000 / 60).toStringAsFixed(0)} minutes',
                      ),
                    ],
                  ],
                ),
              ),

              // Sample Data Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Sample External API Data',
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grayScale,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              if (isLoading)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.h),
                    child: CircularProgressIndicator(
                      color: AppColorsLight.primary,
                    ),
                  ),
                )
              else if (error != null)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.red),
                        SizedBox(height: 16.h),
                        Text(
                          'Error: $error',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16.w),
                  itemCount: apiData.length,
                  itemBuilder: (context, index) {
                    final item = apiData[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.w),
                        leading: CircleAvatar(
                          backgroundColor: AppColorsLight.primary,
                          child: Text(
                            '${item['id']}',
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          item['title'] ?? 'No title',
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            item['body'] ?? 'No description',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.grayScale,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}
