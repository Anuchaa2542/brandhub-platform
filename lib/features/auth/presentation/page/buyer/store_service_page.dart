// features/buyer/presentation/pages/store_services_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreServicesPage extends StatelessWidget {
  const StoreServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // รับข้อมูลร้านจาก arguments
    final store = Get.arguments as Map<String, dynamic>? ?? {};
    final name = store['name'] ?? 'ไม่ระบุร้าน';

    // Mock data บริการและราคา (hardcode)
    final List<Map<String, dynamic>> mockServices = [
      {
        'method': 'DTG (Direct to Garment)',
        'price': '80-150 บาท/ตัว',
        'minOrder': '30 ตัวขึ้นไป',
        'description': 'พิมพ์สีเต็มรูปแบบ คุณภาพสูง เหมาะกับลายสีสันเยอะ',
        'bestFor': 'เสื้อยืด, ผ้าฝ้าย',
      },
      {
        'method': 'DTF (Direct to Film)',
        'price': '50-120 บาท/ตัว',
        'minOrder': '20 ตัวขึ้นไป',
        'description': 'ถ่ายโอนลายจากฟิล์ม ทนทาน ซักได้ดี',
        'bestFor': 'เสื้อผ้าทุกประเภท, กางเกง, หมวก',
      },
      {
        'method': 'Silk Screen',
        'price': '20-80 บาท/ตัว',
        'minOrder': '100 ตัวขึ้นไป',
        'description': 'แบบดั้งเดิม ราคาถูกเมื่อสั่งจำนวนมาก',
        'bestFor': 'ลายเรียบง่าย 1-4 สี',
      },
      {
        'method': 'UV Printing',
        'price': '100-200 บาท/ชิ้น',
        'minOrder': '10 ชิ้นขึ้นไป',
        'description': 'พิมพ์ตรงบนวัสดุแข็ง',
        'bestFor': 'แก้วน้ำ, ร่ม, โลหะ',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText("บริการและราคา - $name", style: AppTextStyles.h2),
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
              AppText(
                "บริการสกรีนทั้งหมด",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "ราคาและขั้นต่ำอาจเปลี่ยนแปลงได้ตามจำนวนและวัสดุ กรุณาสอบถามร้านโดยตรง",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              ...mockServices.map((service) {
                return Card(
                  margin: EdgeInsets.only(bottom: AppSizes.md),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd),
                  child: ExpansionTile(
                    leading: Icon(Icons.print, color: AppColors.accent, size: 32.sp),
                    title: AppText(service['method'], style: AppTextStyles.h3),
                    subtitle: AppText("${service['price']} (ขั้นต่ำ ${service['minOrder']})", style: AppTextStyles.bodyMd.copyWith(color: AppColors.accent)),
                    childrenPadding: EdgeInsets.all(AppSizes.md),
                    children: [
                      AppText("รายละเอียด:", style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4.h),
                      AppText(service['description'], style: AppTextStyles.bodyMd),
                      SizedBox(height: 8.h),
                      AppText("เหมาะกับ:", style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w600)),
                      AppText(service['bestFor'], style: AppTextStyles.bodyMd),
                    ],
                  ),
                );
              }),

              SizedBox(height: AppSizes.xxl),

              AppButton(
                label: "ขอใบเสนอราคา",
                onPressed: () {
                  Get.snackbar('ขอใบเสนอราคา', 'กำลังส่งคำขอไปยังร้าน $name (mock)');
                },
              ),
              SizedBox(height: AppSizes.md),

              AppText(
                "ราคานี้เป็นราคาประมาณ ราคาสุดท้ายขึ้นอยู่กับจำนวนและดีไซน์",
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}