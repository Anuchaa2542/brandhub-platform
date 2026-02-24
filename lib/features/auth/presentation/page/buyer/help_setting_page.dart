// features/shared/presentation/pages/help_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatelessWidget {
   HelpPage({super.key});

  // Mock FAQ
  final List<Map<String, dynamic>> faq = [
    {
      'question': 'จะสั่งสกรีนสินค้าได้อย่างไร?',
      'answer': 'เลือก "สร้างออร์เดอร์ใหม่" แล้วทำตามขั้นตอน: เลือกสินค้า → วิธีสกรีน → ออกแบบ → จำนวน → เลือกร้าน → ชำระเงิน'
    },
    {
      'question': 'ขั้นต่ำในการสั่งคือเท่าไหร่?',
      'answer': 'ขึ้นอยู่กับวิธีสกรีนและร้านค้า โดยทั่วไปเริ่มต้นที่ 20-100 ตัว สามารถดูขั้นต่ำได้ในแต่ละวิธีสกรีน'
    },
    {
      'question': 'ใช้เวลาผลิตนานแค่ไหน?',
      'answer': 'โดยเฉลี่ย 3-10 วันทำการ ขึ้นอยู่กับร้านและปริมาณงาน ร้านจะแจ้งกำหนดส่งชัดเจนหลังยืนยันออร์เดอร์'
    },
    {
      'question': 'คืนเงินได้หรือไม่?',
      'answer': 'สามารถคืนเงินได้เฉพาะกรณีร้านไม่สามารถผลิตได้ตามที่ตกลง หากยกเลิกหลังเริ่มผลิตจะไม่สามารถคืนเงินได้'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ช่วยเหลือ & คำถามที่พบบ่อย", style: AppTextStyles.h2),
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
              AppText(
                "คำถามที่พบบ่อย (FAQ)",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "หาคำตอบสำหรับคำถามทั่วไปได้ที่นี่",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              ...faq.map((item) {
                return ExpansionTile(
                  title: AppText(item['question'], style: AppTextStyles.bodyLg),
                  childrenPadding: EdgeInsets.all(AppSizes.md),
                  children: [
                    AppText(item['answer'], style: AppTextStyles.bodyMd),
                  ],
                );
              }),

              SizedBox(height: AppSizes.xl),

              AppText("ยังมีคำถามอื่น?", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),
              AppButton(
                label: "ติดต่อฝ่ายสนับสนุน",
                onPressed: () {
                  Get.snackbar('ติดต่อเรา', 'ส่งข้อความถึง support@brandhub.com (mock)');
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