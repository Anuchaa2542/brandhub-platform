// features/buyer/presentation/pages/store_reviews_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreReviewsPage extends StatelessWidget {
  const StoreReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // รับข้อมูลร้านจาก arguments
    final store = Get.arguments as Map<String, dynamic>? ?? {};
    final name = store['name'] ?? 'ไม่ระบุร้าน';
    final rating = store['rating'] ?? 0.0;
    final reviewsCount = store['reviews'] ?? 0;

    // Mock data รีวิว (hardcode ในหน้า)
    final List<Map<String, dynamic>> mockReviews = [
      {
        'user': 'น้องมิ้นท์',
        'rating': 5.0,
        'date': '15 ก.พ. 2569',
        'comment':
            'สกรีนสวยมาก สีไม่ตก สั่ง 100 ตัวได้เร็วมาก ร้านบริการดีสุด ๆ',
        'images': ['assets/mockup/review1.jpg', 'assets/mockup/review2.jpg'],
      },
      {
        'user': 'พี่โจ้',
        'rating': 4.5,
        'date': '10 ก.พ. 2569',
        'comment':
            'ราคาไม่แพง คุณภาพดี ส่งตรงเวลา แต่แพ็คเกจอาจจะต้องปรับปรุงนิดนึง',
        'images': ['assets/mockup/review3.jpg'],
      },
      {
        'user': 'คุณแอน',
        'rating': 5.0,
        'date': '5 ก.พ. 2569',
        'comment': 'ฟรี neck label จริง ๆ งานออกมาสวยเป๊ะ สั่งซ้ำแน่นอน',
        'images': [],
      },
      {
        'user': 'น้องตั้ม',
        'rating': 4.0,
        'date': '1 ก.พ. 2569',
        'comment': 'ส่งช้ากว่าที่บอกนิดหน่อย แต่คุณภาพดี คุ้มค่าเงิน',
        'images': ['assets/mockup/review4.jpg'],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText("รีวิว $name", style: AppTextStyles.h2),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.lg),

              // สรุปคะแนนรวม
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor()
                              ? Icons.star
                              : (index < rating
                                    ? Icons.star_half
                                    : Icons.star_border),
                          color: Colors.amber,
                          size: 40.sp,
                        );
                      }),
                    ),
                    SizedBox(height: AppSizes.sm),
                    AppText(
                      "$rating จาก $reviewsCount รีวิว",
                      style: AppTextStyles.h3,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xl),

              AppText("รีวิวจากลูกค้า", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),

              ...mockReviews.map((review) {
                final user = review['user'];
                final rating = review['rating'];
                final date = review['date'];
                final comment = review['comment'];
                final images = review['images'] as List<dynamic>? ?? [];

                return Card(
                  margin: EdgeInsets.only(bottom: AppSizes.md),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd),
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              user,
                              style: AppTextStyles.bodyLg.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < rating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 18.sp,
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        AppText(
                          date,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        AppText(comment, style: AppTextStyles.bodyMd),
                        if (images.isNotEmpty) ...[
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 100.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: images.map((img) {
                                return Padding(
                                  padding: EdgeInsets.only(right: AppSizes.sm),
                                  child: ClipRRect(
                                    borderRadius: AppRadius.allSm,
                                    child: Image.asset(
                                      img,
                                      width: 100.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
