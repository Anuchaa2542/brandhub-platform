// features/buyer/presentation/pages/store_detail_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // รับข้อมูลร้านจาก arguments (ส่งมาจาก StoresPage)
    final store = Get.arguments as Map<String, dynamic>? ?? {};

    final name = store['name'] ?? 'ไม่ระบุร้าน';
    final rating = store['rating'] ?? 0.0;
    final reviews = store['reviews'] ?? 0;
    final description = store['description'] ?? '';
    final highlight = store['highlight'] ?? '';
    final address = store['address'] ?? 'ไม่ระบุ';
    final phone = store['phone'] ?? 'ไม่ระบุ';
    final line = store['line'] ?? 'ไม่ระบุ';
    final website = store['website'] ?? 'ไม่ระบุ';
    final logo = store['logo'] ?? 'assets/store_logo/default.png';
    final services =
        (store['services'] as List<dynamic>?)?.join(' • ') ?? 'ไม่ระบุ';
    final minOrder = store['minOrder'] ?? 'ไม่ระบุ';
    final delivery = store['delivery'] ?? 'ไม่ระบุ';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText("รายละเอียดร้านค้า", style: AppTextStyles.h2),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header ร้าน (โลโก้ + ชื่อ + rating)
              Container(
                padding: EdgeInsets.all(AppSizes.lg),
                color: AppColors.surface,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.surface,
                      backgroundImage: AssetImage(logo),
                      child: logo == 'assets/store_logo/default.png'
                          ? Icon(
                              Icons.store,
                              size: 60.sp,
                              color: AppColors.accent,
                            )
                          : null,
                    ),
                    SizedBox(height: AppSizes.md),
                    AppText(name, style: AppTextStyles.h2),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 20.sp, color: Colors.amber),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.storeReviews,
                              arguments: store,
                            ); // ส่งข้อมูลร้านไปหน้ารีวิว
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20.sp,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 8.w),
                              AppText(
                                "$rating ($reviews รีวิว)",
                                style: AppTextStyles.bodyLg,
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.chevron_right,
                                size: 20.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    AppText(
                      highlight,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),

              // ข้อมูลร้าน
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.xl),
                    AppText("เกี่ยวกับร้านค้า", style: AppTextStyles.h3),
                    SizedBox(height: AppSizes.sm),
                    AppText(description, style: AppTextStyles.bodyMd),

                    SizedBox(height: AppSizes.xl),
                    _buildDetailRow("ที่อยู่", address),
                    _buildDetailRow("เบอร์โทร", phone),
                    _buildDetailRow("Line ID", line),
                    _buildDetailRow("เว็บไซต์", website),

                    SizedBox(height: AppSizes.xl),
                    AppText("บริการที่รองรับ", style: AppTextStyles.h3),
                    SizedBox(height: AppSizes.sm),
                    AppText(services, style: AppTextStyles.bodyMd),

                    SizedBox(height: AppSizes.xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoBox("ขั้นต่ำ", minOrder),
                        _buildInfoBox("ระยะเวลาผลิต", delivery),
                      ],
                    ),

                    SizedBox(height: AppSizes.xxl * 1.5),

                    // ปุ่มติดต่อ / ดูบริการ
                    AppButton(
                      label: "ติดต่อร้านค้า",
                      onPressed: () {
                        Get.snackbar(
                          'ติดต่อ $name',
                          'กำลังเปิดแชท Line หรือโทร (mock)',
                        );
                        Get.toNamed(
                          AppRoutes.contactStore,
                          arguments: store,
                        ); // ส่งข้อมูลร้านไป
                      },
                    ),
                    SizedBox(height: AppSizes.md),
                    AppButton(
                      label: "ดูบริการและราคา",
                      isOutlined: true,
                      onPressed: () {
                        Get.snackbar(
                          'ดูบริการ',
                          'แสดงรายการบริการทั้งหมดของร้าน (mock)',
                        );
                        Get.toNamed(
                          AppRoutes.storeServices,
                          arguments: store,
                        ); // ส่งข้อมูลร้านไป
                      },
                    ),
                    SizedBox(height: AppSizes.xxl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "$label:",
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(width: AppSizes.md),
          Expanded(child: AppText(value, style: AppTextStyles.bodyMd)),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.allMd,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          AppText(
            value,
            style: AppTextStyles.h4.copyWith(color: AppColors.accent),
          ),
          SizedBox(height: 4.h),
          AppText(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
