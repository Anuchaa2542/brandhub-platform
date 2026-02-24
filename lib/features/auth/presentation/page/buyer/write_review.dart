// features/buyer/presentation/pages/write_review_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/features/auth/presentation/controller/buyer_controller/write_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final ReviewController controller = Get.put(ReviewController());

  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final storeName = args['storeName'] ?? 'ไม่ระบุร้าน';
    final orderId = args['orderId'] ?? 'ไม่ระบุ';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText("เขียนรีวิว $storeName", style: AppTextStyles.h2),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSizes.lg),

              AppText("รีวิวออร์เดอร์ #$orderId", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),
              AppText(
                "บอกความรู้สึกของคุณเกี่ยวกับร้านค้าและบริการ",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.xl),

              // เลือกดาว (5 ดาว)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 48.sp,
                    ),
                    onPressed: () => setState(() => _rating = index + 1),
                  );
                }),
              ),
              SizedBox(height: AppSizes.sm),
              AppText("$_rating จาก 5", style: AppTextStyles.bodyLg.copyWith(color: _rating > 0 ? AppColors.accent : AppColors.textSecondary)),

              SizedBox(height: AppSizes.xl),

              // พิมพ์ข้อความรีวิว
              TextField(
                controller: _commentController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "เขียนรีวิวของคุณที่นี่...",
                  hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                  border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: EdgeInsets.all(AppSizes.md),
                ),
              ),
              SizedBox(height: AppSizes.xl),

              // แนบรูป (mock)
              AppButton(
                label: "แนบรูปภาพผลงาน (optional)",
                isOutlined: true,
                onPressed: () {
                  Get.snackbar('แนบรูป', 'เลือกภาพจากอัลบั้ม (mock - ยังไม่เปิด picker จริง)');
                },
              ),
              SizedBox(height: AppSizes.xxl),

              // ปุ่มส่งรีวิว
              AppButton(
                label: "ส่งรีวิว",
                onPressed: () {
                  if (_rating == 0) {
                    Get.snackbar('แจ้งเตือน', 'กรุณาให้คะแนนก่อนส่ง', backgroundColor: Colors.orange);
                    return;
                  }
                  if (_commentController.text.trim().isEmpty) {
                    Get.snackbar('แจ้งเตือน', 'กรุณาเขียนรีวิวสักหน่อย', backgroundColor: Colors.orange);
                    return;
                  }

                  // บันทึก mock ผ่าน controller
                  controller.addReview(
                    storeName: storeName,
                    rating: _rating.toDouble(),
                    comment: _commentController.text.trim(),
                    user: 'Chazilla', // mock ชื่อผู้ใช้
                  );

                  Get.snackbar(
                    'รีวิวสำเร็จ',
                    'ขอบคุณสำหรับรีวิวของคุณ! จะแสดงในหน้ารีวิวร้านทันที',
                    backgroundColor: Colors.green,
                  );

                  Get.back(); // ย้อนกลับ
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