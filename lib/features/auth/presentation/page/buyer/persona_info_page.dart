// features/shared/presentation/pages/personal_info_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock ข้อมูลส่วนตัว (hardcode)
    const mockData = {
      'name': 'Chazilla',
      'email': 'chazilla@example.com',
      'phone': '081-234-5678',
      'address': '123 ถนนสุขุมวิท แขวงคลองเตย เขตคลองเตย กรุงเทพฯ 10110',
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ข้อมูลส่วนตัว", style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.lg),

              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.surface,
                      child: Icon(Icons.person, size: 80.sp, color: AppColors.textSecondary),
                    ),
                    SizedBox(height: AppSizes.md),
                    AppText(mockData['name'] as String, style: AppTextStyles.h2),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xl),

              _buildInfoTile("ชื่อ-นามสกุล", mockData['name']as String),
              _buildInfoTile("อีเมล", mockData['email'] as String),
              _buildInfoTile("เบอร์โทรศัพท์", mockData['phone'] as String),
              _buildInfoTile("ที่อยู่จัดส่ง", mockData['address'] as String),

              SizedBox(height: AppSizes.xxl),

              AppButton(
                label: "แก้ไขข้อมูล",
                onPressed: () {
                  Get.snackbar('แจ้งเตือน', 'ฟังก์ชันแก้ไขข้อมูล (mock)');
                Get.toNamed('/personal-info-edit');
                },
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.md),
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.allMd,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              SizedBox(height: 4.h),
              AppText(value, style: AppTextStyles.bodyLg),
            ],
          ),
          Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}