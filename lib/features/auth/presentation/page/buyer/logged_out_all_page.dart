// features/shared/presentation/pages/logout_all_devices_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogoutAllDevicesPage extends StatelessWidget {
  const LogoutAllDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ออกจากระบบทุกอุปกรณ์", style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber_rounded, size: 100.sp, color: AppColors.error),
              SizedBox(height: AppSizes.xl),
              AppText(
                "คุณแน่ใจหรือไม่?",
                style: AppTextStyles.h2.copyWith(color: AppColors.error),
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.md),
              AppText(
                "การกระทำนี้จะออกจากระบบทุกอุปกรณ์ที่กำลังล็อกอินอยู่ ยกเว้นอุปกรณ์นี้",
                style: AppTextStyles.bodyMd,
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.xxl),

              AppButton(
                label: "ยืนยัน ออกจากระบบทุกอุปกรณ์",
                backgroundColor: AppColors.error,
                onPressed: () {
                  Get.snackbar('สำเร็จ', 'ออกจากระบบทุกอุปกรณ์แล้ว (ยกเว้นเครื่องนี้) - mock');
                  Get.offAllNamed(AppRoutes.login);
                },
              ),
              SizedBox(height: AppSizes.md),

              TextButton(
                onPressed: () => Get.back(),
                child: AppText("ยกเลิก", style: AppTextStyles.bodyMd.copyWith(color: AppColors.primary)),
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}