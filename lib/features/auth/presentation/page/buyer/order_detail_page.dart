// features/buyer/presentation/pages/order_detail_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // รับข้อมูลจาก arguments (ส่งมาจาก OrdersPage)
    final order = Get.arguments as Map<String, dynamic>? ?? {};

    final id = order['id'] ?? 'ไม่ระบุ';
    final date = order['date'] ?? '';
    final items = order['items'] ?? '';
    final status = order['status'] ?? '';
    final total = order['total'] ?? '';
    final product = order['product'] ?? '';
    final method = order['method'] ?? '';
    final quantity = order['quantity'] ?? 0;
    final position = order['position'] ?? '';
    final imagePath =
        order['imagePath'] ?? 'assets/mockup/placeholder.png'; // รูป mockup
    final store = order['store'] ?? '';
    final deliveryDate = order['deliveryDate'] ?? '';
    final packages =
        (order['packages'] as List<dynamic>?)?.join(', ') ?? 'ไม่มี';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false, // ไม่มีปุ่ม back
        title: AppText("รายละเอียดออร์เดอร์ #$id", style: AppTextStyles.h2),
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

              // สถานะออร์เดอร์ (ใหญ่และเด่น)
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.xl,
                    vertical: AppSizes.md,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    borderRadius: AppRadius.allLg,
                  ),
                  child: AppText(
                    status.toUpperCase(),
                    style: AppTextStyles.h1.copyWith(
                      color: _getStatusColor(status),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.xl),

              // รูป preview การสกรีน
              Center(
                child: Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.allMd,
                    border: Border.all(color: AppColors.divider),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.md),
              Center(
                child: AppText(
                  "ตัวอย่างการสกรีน ($position)",
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.xl),

              // รายละเอียด
              _buildDetailSection("ข้อมูลออร์เดอร์", [
                _buildDetailRow("เลขที่ออร์เดอร์", id),
                _buildDetailRow("วันที่สั่ง", date),
                _buildDetailRow("สินค้า", product),
                _buildDetailRow("วิธีสกรีน", method),
                _buildDetailRow("จำนวน", "$quantity ตัว"),
                _buildDetailRow("ตำแหน่งสกรีน", position),
              ]),

              _buildDetailSection("ร้านค้า & การจัดส่ง", [
                _buildDetailRow("ร้านที่เลือก", store),
                _buildDetailRow("กำหนดส่งโดยประมาณ", deliveryDate),
              ]),

              _buildDetailSection("Package เพิ่มเติม", [
                _buildDetailRow("รวม", packages.isEmpty ? "ไม่มี" : packages),
              ]),

              _buildDetailSection("สรุปค่าใช้จ่าย", [
                _buildDetailRow("ยอดรวมทั้งสิ้น", total, highlight: true),
              ]),

              SizedBox(height: AppSizes.xxl),

              // ปุ่มติดต่อร้าน / ดาวน์โหลดใบเสร็จ (mock)
              AppButton(
                label: "ติดต่อร้านค้า",
                isOutlined: true,
                onPressed: () {
                  Get.snackbar(
                    'ติดต่อร้าน',
                    'กำลังเปิดแชทกับร้าน $store (mock)',
                  );
                  Get.toNamed(
                    AppRoutes.sendMessageToStore,
                    arguments: {'name': store},
                  );
                },
              ),
              SizedBox(height: AppSizes.md),
              AppButton(
                label: "ดาวน์โหลดใบเสร็จ / รายละเอียด",
                onPressed: () {
                  Get.snackbar(
                    'ดาวน์โหลด',
                    'ไฟล์ PDF ใบเสร็จถูกดาวน์โหลดแล้ว (mock)',
                  );
                  Get.toNamed(
                    AppRoutes.downloadReceipt,
                    arguments: order,
                  ); // ส่งข้อมูลออร์เดอร์ไป
                },
              ),
              SizedBox(height: AppSizes.xxl),

              SizedBox(height: AppSizes.md),

// แสดงปุ่มรีวิวเฉพาะเมื่อสถานะ "ส่งมอบแล้ว"
if (status == 'ส่งมอบแล้ว')
  AppButton(
    label: "เขียนรีวิวร้านค้า",
    isOutlined: true,
    icon: Icon(Icons.star_border, color: AppColors.accent),
    onPressed: () {
      Get.toNamed(AppRoutes.writeReview, arguments: {
        'storeName': store,
        'orderId': id,
      });
    },
  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title, style: AppTextStyles.h3),
        SizedBox(height: AppSizes.sm),
        Container(
          padding: EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.allMd,
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(children: children),
        ),
        SizedBox(height: AppSizes.lg),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool highlight = false}) {
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
              fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
              color: highlight ? AppColors.accent : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'กำลังผลิต':
        return Colors.orange;
      case 'ส่งมอบแล้ว':
        return Colors.green;
      case 'รอชำระเงิน':
        return Colors.red;
      case 'ยกเลิก':
        return Colors.grey;
      default:
        return AppColors.textSecondary;
    }
  }
}
