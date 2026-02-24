// features/buyer/presentation/pages/orders_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_bottom_nav_bar.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  // Mock data ออร์เดอร์ทั้งหมด (hardcode ในหน้า)
  final List<Map<String, dynamic>> mockOrders = [
    {
      'id': 'ORD-20250224-001',
      'date': '24 ก.พ. 2569',
      'items': 'เสื้อยืด Oversize x 50 ตัว, DTG สีเต็ม',
      'status': 'กำลังผลิต',
      'total': '12,500 บาท',
    },
    {
      'id': 'ORD-20250220-045',
      'date': '20 ก.พ. 2569',
      'items': 'แก้วน้ำสกรีนโลโก้ x 200 ใบ, DTF',
      'status': 'ส่งมอบแล้ว',
      'total': '18,000 บาท',
    },
    {
      'id': 'ORD-20250215-112',
      'date': '15 ก.พ. 2569',
      'items': 'หมวก Snapback x 100 ใบ',
      'status': 'รอชำระเงิน',
      'total': '9,800 บาท',
    },
    {
      'id': 'ORD-20250210-089',
      'date': '10 ก.พ. 2569',
      'items': 'กางเกง Sweatpants x 30 ตัว, Silk Screen',
      'status': 'ยกเลิก',
      'total': '6,900 บาท',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false, // ไม่มีปุ่ม back
        title: AppText("ออร์เดอร์ของฉัน", style: AppTextStyles.h2),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.lg),
              AppText("ออร์เดอร์ทั้งหมด", style: AppTextStyles.displaySm),
              SizedBox(height: AppSizes.sm),
              AppText(
                "ติดตามสถานะออร์เดอร์ของคุณ",
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.xl),

              Expanded(
                child: ListView.builder(
                  itemCount: mockOrders.length,
                  itemBuilder: (context, index) {
                    final order = mockOrders[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: AppSizes.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.allMd,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(AppSizes.md),
                        title: AppText(
                          "เลขที่: ${order['id']}",
                          style: AppTextStyles.bodyLg,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4.h),
                            AppText(
                              order['items'],
                              style: AppTextStyles.bodyMd,
                            ),
                            SizedBox(height: 4.h),
                            AppText(
                              order['date'],
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  order['status'],
                                ).withOpacity(0.1),
                                borderRadius: AppRadius.allXs,
                              ),
                              child: AppText(
                                order['status'],
                                style: AppTextStyles.caption.copyWith(
                                  color: _getStatusColor(order['status']),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            AppText(
                              "${order['total']}",
                              style: AppTextStyles.bodyMd.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // ไปหน้า detail ถ้ามี (หรือแสดง dialog)
                          Get.snackbar(
                            'รายละเอียด',
                            'ออร์เดอร์ ${order['id']} - ${order['status']}',
                          );
                          Get.toNamed(AppRoutes.orderDetail, arguments: order);
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
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1, // สมมติว่า Settings เป็น index 3
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(AppRoutes.homePage);
          } else if (index == 1) {
          } else if (index == 2) {
            Get.toNamed(AppRoutes.stores);
          } else if (index == 3) {
            Get.toNamed(AppRoutes.settings);
          }
        },
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
