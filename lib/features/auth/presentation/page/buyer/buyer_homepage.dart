// features/buyer/presentation/pages/buyer_home_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_bottom_nav_bar.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/features/auth/presentation/controller/buyer_controller/buyer_home_controller.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuyerHomePage extends StatelessWidget {
  BuyerHomePage({super.key});

  // Mock data ออร์เดอร์ล่าสุด (hardcode)
  final List<Map<String, dynamic>> recentOrders = [
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
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BuyerHomeController());

    return Scaffold(
      extendBody: true, // ให้ background ทึบถึงขอบล่าง
      resizeToAvoidBottomInset: false, // ป้องกัน keyboard push content
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText(
          "BrandHub",
          style: AppTextStyles.h1.copyWith(color: AppColors.primary),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () => Get.toNamed(AppRoutes.notifications),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false, // ให้ BottomNav ทับได้ แต่ content ไม่ล้น
        child: Obx(() {
          if (controller.currentIndex.value != 0) {
            // สำหรับ tab อื่น (Orders, Stores, Profile) ให้แสดง IndexedStack ตามปกติ
            return controller.tabPages[controller.currentIndex.value];
          }

          // Tab 0: หน้าแรก (HomeContent รวมที่นี่)
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: AppSizes.screenPadding,
              right: AppSizes.screenPadding,
              bottom: AppSizes.bottomNavHeight + 20.h, // ป้องกัน BottomNav ทับ
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.lg),
                AppText(
                  "สวัสดี! พร้อมสั่งสกรีนวันนี้มั้ย?",
                  style: AppTextStyles.displaySm.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.sm),
                AppText(
                  "เริ่มสร้างงานสกรีนของคุณง่าย ๆ ใน 3 ขั้นตอน",
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.xl),

                AppButton(
                  label: "สร้างออร์เดอร์ใหม่",
                  onPressed: () => Get.toNamed(AppRoutes.serviceTypeSelection),
                  icon: Icon(Icons.add_circle_outline, color: Colors.white),
                ),
                SizedBox(height: AppSizes.lg),

                // Banner โปรโมชั่น
                Container(
                  height: 160.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.allLg,
                    gradient: LinearGradient(
                      colors: [AppColors.accent, Color(0xFFFF8A65)],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "โปรโมชั่นพิเศษ!",
                          style: AppTextStyles.h2.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: AppSizes.xs),
                        AppText(
                          "สั่งครั้งแรก ลด 20% ทุกวิธีสกรีน",
                          style: AppTextStyles.bodyLg.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.xl),

                AppText("หมวดหมู่ยอดนิยม", style: AppTextStyles.h3),
                SizedBox(height: AppSizes.md),
                SizedBox(
                  height: 100.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryCard("เสื้อยืด", Icons.checkroom),
                      SizedBox(width: AppSizes.md),
                      _buildCategoryCard("กางเกง", Icons.accessibility_new),
                      SizedBox(width: AppSizes.md),
                      _buildCategoryCard("แก้วน้ำ", Icons.local_drink),
                      SizedBox(width: AppSizes.md),
                      _buildCategoryCard("หมวก", Icons.emoji_people),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.xl),

                // ถ้ามี recent orders (optional)
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0, // สมมติว่า Settings เป็น index 3
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Get.toNamed(AppRoutes.orders);
          } else if (index == 2) {
            Get.toNamed(AppRoutes.stores);
          } else if (index == 3) {
            Get.toNamed(AppRoutes.settings);
          }
        },
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.productSelection,
        arguments: {'category': title},
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.allMd,
              border: Border.all(color: AppColors.divider),
            ),
            child: Icon(icon, size: 40.sp, color: AppColors.accent),
          ),
          SizedBox(height: AppSizes.xs),
          AppText(title, style: AppTextStyles.caption),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.md),
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.allMd,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText("เลขที่: ${order['id']}", style: AppTextStyles.bodyLg),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(order['status']).withOpacity(0.1),
                  borderRadius: AppRadius.allXs,
                ),
                child: AppText(
                  order['status'],
                  style: AppTextStyles.caption.copyWith(
                    color: _getStatusColor(order['status']),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.xs),
          AppText(
            order['date'],
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSizes.sm),
          AppText(order['items'], style: AppTextStyles.bodyMd),
          SizedBox(height: AppSizes.sm),
          AppText(
            "ยอดรวม: ${order['total']}",
            style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
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
      default:
        return AppColors.textSecondary;
    }
  }
}
