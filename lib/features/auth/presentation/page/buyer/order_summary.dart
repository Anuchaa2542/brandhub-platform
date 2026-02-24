// features/buyer/presentation/pages/order_summary_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    final product = args['product'] ?? 'ไม่ระบุสินค้า';
    final method = args['screenMethod'] ?? 'ไม่ระบุวิธีผลิต';
    final quantity = args['quantity'] ?? 0;
    final total = args['totalPrice'] ?? 0.0;
    final store = args['selectedStore'] ?? 'ไม่ระบุร้าน';
    final packages = args['packages'] as Map<String, bool>? ?? {};

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("สรุปออร์เดอร์", style: AppTextStyles.h2),
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
              AppText("สรุปออร์เดอร์ของคุณ", style: AppTextStyles.displaySm),
              SizedBox(height: AppSizes.sm),

              Container(
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.allMd,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("สินค้า", product),
                    _buildRow("วิธีผลิต/สกรีน", method),
                    _buildRow("จำนวน", "$quantity ตัว"),
                    _buildRow("ร้านที่เลือก", store),
                    if (packages.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      AppText(
                        "Package เพิ่มเติม:",
                        style: AppTextStyles.caption,
                      ),
                      ...packages.entries
                          .where((e) => e.value)
                          .map(
                            (e) => AppText(
                              "• ${e.key}",
                              style: AppTextStyles.caption,
                            ),
                          ),
                    ],
                    Divider(height: 24.h),
                    _buildRow(
                      "ยอดรวมทั้งสิ้น",
                      "${total.toStringAsFixed(0)} บาท",
                      bold: true,
                      color: AppColors.accent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xxl),

              AppText("วิธีชำระเงิน", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.md),
                  child: Column(
                    children: [
                      ListTile(
                        
                        leading: Icon(Icons.qr_code, color: AppColors.primary),
                        title: AppText("ชำระเงิน"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () =>
                            Get.toNamed(AppRoutes.payment, arguments: args),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool bold = false,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppText(
            value,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              color: color ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
