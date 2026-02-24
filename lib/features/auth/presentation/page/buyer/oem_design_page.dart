import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class UploadOemDesignPage extends StatelessWidget {
  const UploadOemDesignPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final product = args['oemProduct'] ?? 'ไม่ระบุ';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("อัปโหลดแบบ / สเปค", style: AppTextStyles.h2),
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
                "สินค้าที่เลือก: $product",
                style: AppTextStyles.h3,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "อัปโหลดไฟล์แบบ, สเปค, ตัวอย่าง หรือเอกสารที่เกี่ยวข้อง (PDF, AI, PSD, JPG, PNG)",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              AppButton(
                label: "เลือกไฟล์จากเครื่อง",
                isOutlined: true,
                icon: Icon(Icons.upload_file, color: AppColors.primary),
                onPressed: () {
                  Get.snackbar('อัปโหลดไฟล์', 'เลือกไฟล์จากเครื่อง (mock - ยังไม่เปิด picker จริง)');
                },
              ),
              SizedBox(height: AppSizes.md),

              AppButton(
                label: "ถ่ายรูปหรือสแกนเอกสาร",
                isOutlined: true,
                icon: Icon(Icons.camera_alt, color: AppColors.primary),
                onPressed: () {
                  Get.snackbar('ถ่ายรูป', 'เปิดกล้องเพื่อสแกนแบบ/สเปค (mock)');
                },
              ),
              SizedBox(height: AppSizes.xl),

              AppText("แนะนำให้อัปโหลด:", style: AppTextStyles.bodyMd),
              SizedBox(height: AppSizes.sm),
              AppText("• ไฟล์แบบ (AI, PSD, CDR)"),
              AppText("• สเปคขนาด / วัสดุ / สี"),
              AppText("• ตัวอย่างหรือ reference"),
              SizedBox(height: AppSizes.xxl),

              AppButton(
                label: "ดำเนินการต่อ (เลือกจำนวน & แพ็กเกจ)",
                onPressed: () {
                  Get.toNamed(AppRoutes.quantityPackage, arguments: {
                    'isOEM': true,
                    'oemProduct': product,
                  });
                },
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}