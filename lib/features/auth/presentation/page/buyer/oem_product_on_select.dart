// features/buyer/presentation/pages/oem_product_selection_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OEMProductSelectionPage extends StatelessWidget {
   OEMProductSelectionPage({super.key});

  final List<String> oemProducts = [
    'เสื้อผ้า (เสื้อยืด, โปโล, เสื้อกันหนาว, ชุดกีฬา)',
    'แก้ว / ขวด / กระบอกน้ำ',
    'กระเป๋า / ถุงผ้า / กระเป๋าเดินทาง',
    'สติกเกอร์ / ป้าย / ฉลาก / บรรจุภัณฑ์',
    'ของพรีเมียม / ของที่ระลึก / ของชำร่วย',
    'ปากกา / สมุด / อุปกรณ์สำนักงาน custom',
    'อื่น ๆ (ระบุเอง)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("เลือกประเภทสินค้า OEM", style: AppTextStyles.h2),
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
                "เลือกประเภทสินค้าที่ต้องการผลิตใหม่ทั้งชิ้น",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เราจะส่งแบบ/สเปคของคุณไปยังร้านที่เชี่ยวชาญ",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              Expanded(
                child: ListView.builder(
                  itemCount: oemProducts.length,
                  itemBuilder: (context, index) {
                    final product = oemProducts[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: AppSizes.md),
                      child: ListTile(
                        leading: Icon(Icons.add_business, color: AppColors.accent, size: 32.sp),
                        title: AppText(product, style: AppTextStyles.bodyLg),
                        trailing: Icon(Icons.chevron_right, color: AppColors.accent),
                        onTap: () {
                          Get.toNamed(AppRoutes.uploadOemDesign, arguments: {'oemProduct': product});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}