// features/buyer/presentation/pages/download_receipt_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DownloadReceiptPage extends StatelessWidget {
  const DownloadReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Map<String, dynamic>? ?? {};

    final date = order['date'] ?? '20 ก.พ. 2569';
    final store = order['store'] ?? 'ไม่ระบุร้าน';
    final product = order['product'] ?? 'ไม่ระบุสินค้า';
    final quantity = order['quantity'] ?? 0;
    final status = order['status'] ?? 'ส่งมอบแล้ว';
    final total = order['total'] ?? '18,000';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ดาวน์โหลดใบเสร็จ / รายละเอียด", style: AppTextStyles.h2),
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

              // สรุปข้อมูลในกล่อง
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.allMd,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("วันที่ส่ง", date),
                    _buildRow("ร้านค้า", store),
                    _buildRow("สินค้า", product),
                    _buildRow("จำนวน", "$quantity ตัว"),
                    _buildRow("สถานะ", status, color: AppColors.accent),
                    Divider(height: 24.h),
                    _buildRow("ยอดรวม", "$total บาท", color: AppColors.accent, bold: true),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xxl),

              // ปุ่มดาวน์โหลด 3 ปุ่มตามภาพ
              AppButton(
                label: "ดาวน์โหลดใบเสร็จ (PDF)",
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                onPressed: () {
                  Get.snackbar('ดาวน์โหลดสำเร็จ', 'ไฟล์ PDF ใบเสร็จถูกบันทึกแล้ว (mock)');
                },
              ),
              SizedBox(height: AppSizes.md),

              AppButton(
                label: "ดาวน์โหลดรายละเอียดออร์เดอร์ (PDF)",
                isOutlined: true,
                onPressed: () {
                  Get.snackbar('ดาวน์โหลดสำเร็จ', 'ไฟล์ PDF รายละเอียดถูกดาวน์โหลดแล้ว (mock)');
                },
              ),
              SizedBox(height: AppSizes.md),

              AppButton(
                label: "ดาวน์โหลดรูปตัวอย่างการสกรีน",
                isOutlined: true,
                onPressed: () {
                  Get.snackbar('ดาวน์โหลดสำเร็จ', 'รูปภาพถูกบันทึกในอัลบั้ม (mock)');
                },
              ),
              SizedBox(height: AppSizes.xxl),

              Center(
                child: AppText(
                  "ไฟล์ทั้งหมดเป็นรูปแบบ PDF หรือภาพ คุณสามารถเปิดดูได้ในโทรศัพท์หรือคอมพิวเตอร์",
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  align: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {Color? color, bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(label, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
          AppText(
            value,
            style: AppTextStyles.bodyMd.copyWith(
              color: color ?? AppColors.textPrimary,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}