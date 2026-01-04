import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mad_final_project/models/property.dart';
import 'package:mad_final_project/utils/constants.dart';

class DetailsPage extends StatelessWidget {
  final Property property;

  const DetailsPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            backgroundColor: AppColorsLight.primary,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: AppColorsLight.primary),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    property.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: property.isFavorite ? Colors.red : AppColorsLight.primary,
                  ),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                property.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.home, size: 100, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.name,
                          style: GoogleFonts.manrope(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grayScale,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColorsLight.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          property.type,
                          style: GoogleFonts.manrope(
                            color: AppColorsLight.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: Colors.grey[600]),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          property.location,
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    property.price,
                    style: GoogleFonts.manrope(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColorsLight.primary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Property Features',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayScale,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeatureBox(
                        Icons.bed,
                        '${property.bedrooms}',
                        'Bedrooms',
                      ),
                      _buildFeatureBox(
                        Icons.bathtub,
                        '${property.bathrooms}',
                        'Bathrooms',
                      ),
                      _buildFeatureBox(
                        Icons.square_foot,
                        property.area,
                        'Area',
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Description',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayScale,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    property.description,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Amenities',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayScale,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildAmenityChip('Parking'),
                      _buildAmenityChip('Swimming Pool'),
                      _buildAmenityChip('Garden'),
                      _buildAmenityChip('Security 24/7'),
                      _buildAmenityChip('Gym'),
                      _buildAmenityChip('WiFi'),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: AppColorsLight.primary),
                          ),
                          child: Text(
                            'Message',
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColorsLight.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColorsLight.primary,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBox(IconData icon, String value, String label) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColorsLight.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColorsLight.primary, size: 32),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.grayScale,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 12.sp,
          color: AppColorsLight.primary,
        ),
      ),
      backgroundColor: AppColorsLight.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    );
  }
}
