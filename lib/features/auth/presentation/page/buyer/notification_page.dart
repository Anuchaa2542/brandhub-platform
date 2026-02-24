// features/buyer/presentation/pages/notifications_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
   NotificationsPage({super.key});

  // Mock data การแจ้งเตือน (hardcode)
  final List<Map<String, dynamic>> mockNotifications = [
    {
      'title': 'ออร์เดอร์กำลังผลิตแล้ว!',
      'message': 'ร้านสกรีนด่วน สยาม เริ่มผลิตออร์เดอร์ ORD-20250224-001 ของคุณแล้ว',
      'time': 'เมื่อ 2 ชั่วโมงที่แล้ว',
      'read': false,
    },
    {
      'title': 'ส่งของเรียบร้อย',
      'message': 'ออร์เดอร์ ORD-20250220-045 ส่งถึงลูกค้าเรียบร้อยแล้ว ขอบคุณที่ใช้บริการ',
      'time': 'เมื่อ 3 วันที่แล้ว',
      'read': true,
    },
    {
      'title': 'โปรโมชั่นใหม่!',
      'message': 'สั่งครั้งแรกวันนี้ ลด 20% ทุกวิธีสกรีน ใช้โค้ด FIRST20',
      'time': 'เมื่อ 1 สัปดาห์ที่แล้ว',
      'read': true,
    },
    {
      'title': 'รอชำระเงิน',
      'message': 'ออร์เดอร์ ORD-20250215-112 ยังไม่ได้ชำระ กรุณาชำระภายใน 24 ชม.',
      'time': 'เมื่อ 10 วันที่แล้ว',
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("แจ้งเตือน", style: AppTextStyles.h2),
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
                "แจ้งเตือนล่าสุด",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "อัปเดตสถานะออร์เดอร์และข่าวสารโปรโมชั่น",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              Expanded(
                child: ListView.builder(
                  itemCount: mockNotifications.length,
                  itemBuilder: (context, index) {
                    final noti = mockNotifications[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: AppSizes.md),
                      color: noti['read'] ? AppColors.surface : AppColors.surface.withOpacity(0.6),
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: noti['read'] ? AppColors.textSecondary.withOpacity(0.2) : AppColors.accent.withOpacity(0.2),
                          child: Icon(
                            noti['read'] ? Icons.notifications_none : Icons.notifications_active,
                            color: noti['read'] ? AppColors.textSecondary : AppColors.accent,
                          ),
                        ),
                        title: AppText(noti['title'], style: AppTextStyles.bodyLg.copyWith(fontWeight: noti['read'] ? FontWeight.normal : FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4.h),
                            AppText(noti['message'], style: AppTextStyles.bodyMd),
                            SizedBox(height: 4.h),
                            AppText(noti['time'], style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                        onTap: () {
                          // Mock เปิดดูรายละเอียด
                          Get.snackbar('แจ้งเตือน', noti['title']);
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