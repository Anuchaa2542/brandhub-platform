// features/shared/presentation/pages/logged_in_devices_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoggedInDevicesPage extends StatelessWidget {
   LoggedInDevicesPage({super.key});

  // Mock อุปกรณ์
  final List<Map<String, dynamic>> mockDevices = [
    {
      'device': 'Samsung Galaxy S23',
      'location': 'กรุงเทพมหานคร, ประเทศไทย',
      'lastActive': 'เมื่อ 5 นาทีที่แล้ว',
      'thisDevice': true,
    },
    {
      'device': 'Windows PC - Chrome',
      'location': 'กรุงเทพมหานคร, ประเทศไทย',
      'lastActive': 'เมื่อ 2 ชั่วโมงที่แล้ว',
      'thisDevice': false,
    },
    {
      'device': 'iPad Pro',
      'location': 'กรุงเทพมหานคร, ประเทศไทย',
      'lastActive': 'เมื่อ 3 วันที่แล้ว',
      'thisDevice': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("อุปกรณ์ที่ล็อกอิน", style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.lg),
              AppText(
                "อุปกรณ์ที่เข้าสู่ระบบปัจจุบัน",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "คุณสามารถออกจากระบบอุปกรณ์ที่ไม่รู้จักได้ที่นี่",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              ...mockDevices.map((device) {
                final isThisDevice = device['thisDevice'];
                return Card(
                  margin: EdgeInsets.only(bottom: AppSizes.md),
                  child: ListTile(
                    leading: Icon(
                      isThisDevice ? Icons.smartphone : Icons.computer,
                      color: isThisDevice ? AppColors.accent : AppColors.textSecondary,
                    ),
                    title: AppText(device['device'], style: AppTextStyles.bodyLg),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(device['location'], style: AppTextStyles.caption),
                        SizedBox(height: 4.h),
                        AppText(device['lastActive'], style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                        if (isThisDevice)
                          AppText("(อุปกรณ์นี้)", style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
                      ],
                    ),
                    trailing: isThisDevice
                        ? null
                        : IconButton(
                            icon: Icon(Icons.logout, color: AppColors.error),
                            onPressed: () {
                              Get.snackbar('สำเร็จ', 'ออกจากระบบ ${device['device']} แล้ว (mock)');
                            },
                          ),
                  ),
                );
              }),

              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}