// features/buyer/presentation/pages/service_type_selection_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceTypeSelectionPage extends StatelessWidget {
  const ServiceTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("เลือกประเภทบริการ", style: AppTextStyles.h2),
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
                "คุณต้องการบริการแบบไหนวันนี้?",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เลือกประเภทที่ตรงกับความต้องการของคุณ",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl * 1.5),

              _buildServiceOption(
                title: "สกรีนบนสินค้าสำเร็จรูป",
                description: "เลือกเสื้อ แก้ว หมวก กระเป๋า ที่มีอยู่แล้ว แล้วสกรีนลายตามต้องการ",
                icon: Icons.print,
                onTap: () => Get.toNamed(AppRoutes.productSelection),
              ),
              SizedBox(height: AppSizes.lg),

              _buildServiceOption(
                title: "ผลิต OEM / Custom ผลิตใหม่ทั้งชิ้น",
                description: "ผลิตสินค้าตามแบบของคุณเองตั้งแต่ต้นจนจบ ไม่มีสินค้าสำเร็จรูป",
                icon: Icons.factory,
                onTap: () => Get.toNamed(AppRoutes.oemProductSelection),
              ),
              SizedBox(height: AppSizes.lg),

              _buildServiceOption(
                title: "บริการอื่น ๆ (ออกแบบ + ผลิตครบวงจร)",
                description: "ออกแบบโลโก้, ตัดเย็บ, บรรจุภัณฑ์ custom, ผลิตป้าย/ของพรีเมียม",
                icon: Icons.build,
                onTap: () {
                  Get.snackbar('บริการอื่น ๆ', 'กำลังพัฒนาเพิ่มเติม (mock)');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceOption({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: AppRadius.allMd,
                ),
                child: Icon(icon, size: 36.sp, color: AppColors.accent),
              ),
              SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(title, style: AppTextStyles.h3),
                    SizedBox(height: 4.h),
                    AppText(description, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.accent),
            ],
          ),
        ),
      ),
    );
  }
}