import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool notificationsEnabled = true;
  bool propertyAlertsEnabled = true;
  bool priceDropAlertsEnabled = true;
  bool newListingsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notifications') ?? true;
      propertyAlertsEnabled = prefs.getBool('propertyAlerts') ?? true;
      priceDropAlertsEnabled = prefs.getBool('priceDropAlerts') ?? true;
      newListingsEnabled = prefs.getBool('newListings') ?? true;
    });
  }

  Future<void> _saveNotificationSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _sendTestNotification() {
    // First show dialog immediately
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColorsLight.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_active,
                color: AppColorsLight.primary,
                size: 28,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Test Notification',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.villa, color: AppColorsLight.primary, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'New Property Alert!',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColorsLight.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'A new luxury villa has been listed in Bali that matches your preferences.',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildNotificationDetail(Icons.location_on, 'Location', 'Seminyak, Bali'),
              SizedBox(height: 8),
              _buildNotificationDetail(Icons.attach_money, 'Price', 'Rp 3.500.000.000'),
              SizedBox(height: 8),
              _buildNotificationDetail(Icons.bed, 'Bedrooms', '3 Beds'),
              SizedBox(height: 8),
              _buildNotificationDetail(Icons.bathtub, 'Bathrooms', '2 Baths'),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Notification test successful! This is how notifications will appear.',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: Colors.green[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Dismiss',
              style: GoogleFonts.manrope(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Navigating to property details...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorsLight.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            icon: Icon(Icons.open_in_new, size: 18),
            label: Text(
              'View Property',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    // Show success snackbar after dialog is dismissed
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Test notification sent successfully!',
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
      }
    });
  }

  Widget _buildNotificationDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 13,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColorsLight.primary,
        title: Text(
          'Notifications',
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
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Card(
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
                      Icon(
                        Icons.info_outline,
                        color: AppColorsLight.primary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Notification Settings',
                          style: GoogleFonts.manrope(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grayScale,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Manage your notification preferences to stay updated on new properties and price changes.',
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'GENERAL',
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 12.h),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: 'Push Notifications',
            subtitle: 'Receive push notifications for updates',
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() => notificationsEnabled = value);
              _saveNotificationSetting('notifications', value);
            },
          ),
          SizedBox(height: 24.h),
          Text(
            'PROPERTY ALERTS',
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 12.h),
          _buildSwitchTile(
            icon: Icons.home_outlined,
            title: 'Property Alerts',
            subtitle: 'Get notified about properties matching your criteria',
            value: propertyAlertsEnabled,
            onChanged: (value) {
              setState(() => propertyAlertsEnabled = value);
              _saveNotificationSetting('propertyAlerts', value);
            },
          ),
          _buildSwitchTile(
            icon: Icons.trending_down,
            title: 'Price Drop Alerts',
            subtitle: 'Notify when prices drop on saved properties',
            value: priceDropAlertsEnabled,
            onChanged: (value) {
              setState(() => priceDropAlertsEnabled = value);
              _saveNotificationSetting('priceDropAlerts', value);
            },
          ),
          _buildSwitchTile(
            icon: Icons.new_releases_outlined,
            title: 'New Listings',
            subtitle: 'Get notified about new property listings',
            value: newListingsEnabled,
            onChanged: (value) {
              setState(() => newListingsEnabled = value);
              _saveNotificationSetting('newListings', value);
            },
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: _sendTestNotification,
            icon: Icon(Icons.send, color: Colors.white),
            label: Text(
              'Send Test Notification',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorsLight.primary,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Note: Test notification will appear as a banner and dialog to demonstrate the notification system.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColorsLight.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColorsLight.primary, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.grayScale,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            subtitle,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColorsLight.primary,
        ),
      ),
    );
  }
}
