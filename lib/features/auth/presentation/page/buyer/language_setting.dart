// features/shared/presentation/pages/language_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
   LanguagePage({super.key});

  // Mock ภาษาที่รองรับ
  final List<Map<String, dynamic>> languages = [
    {'name': 'ไทย (Thai)', 'code': 'th', 'selected': true},
    {'name': 'English', 'code': 'en', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ภาษา", style: AppTextStyles.h2),
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
                "เลือกภาษาที่ต้องการใช้ในแอป",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "การเปลี่ยนภาษาจะมีผลทันที",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              ...languages.map((lang) {
                final isSelected = lang['selected'];
                return ListTile(
                  title: AppText(lang['name'], style: AppTextStyles.bodyLg),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColors.accent, size: 24.sp)
                      : null,
                  onTap: () {
                    Get.snackbar('เปลี่ยนภาษา', 'เปลี่ยนเป็น ${lang['name']} (mock)');
                  },
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