// features/shared/presentation/pages/settings_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_bottom_nav_bar.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/features/auth/presentation/controller/app_controller.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final role = appController.role.value;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText(
          role == 'seller' ? "ตั้งค่าร้านค้า" : "ตั้งค่า",
          style: AppTextStyles.h2,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: AppSizes.screenPadding,
                right: AppSizes.screenPadding,
                bottom: AppSizes.bottomNavHeight + 20.h,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.lg),

                    // โปรไฟล์ส่วนตัว (mock)
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundColor: AppColors.surface,
                            child: Icon(
                              Icons.person,
                              size: 60.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppSizes.md),
                          AppText("Chazilla", style: AppTextStyles.h2),
                          AppText(
                            "chazilla@example.com",
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.xl),

                    // เมนูตั้งค่า (buyer vs seller)
                    if (role == 'buyer') ...[
                      _buildSettingsTile(
                        icon: Icons.person_outline,
                        title: "ข้อมูลส่วนตัว",
                        subtitle: "แก้ไขชื่อ, อีเมล, เบอร์โทร",
                        onTap: () => Get.toNamed(AppRoutes.personalInfo),
                      ),
                      _buildSettingsTile(
                        icon: Icons.notifications_outlined,
                        title: "การแจ้งเตือน",
                        subtitle: "จัดการแจ้งเตือนออร์เดอร์และโปรโมชั่น",
                        onTap: () => Get.toNamed(AppRoutes.notificationsSettings),
                      ),
                      _buildSettingsTile(
                        icon: Icons.language,
                        title: "ภาษา",
                        subtitle: "ไทย (Thai)",
                        onTap: () => Get.toNamed(AppRoutes.language),
                      ),
                      _buildSettingsTile(
                        icon: Icons.security,
                        title: "ความปลอดภัย",
                        subtitle: "เปลี่ยนรหัสผ่าน, 2FA",
                        onTap: () => Get.toNamed(AppRoutes.security),
                      ),
                      _buildSettingsTile(
                        icon: Icons.help_outline,
                        title: "ช่วยเหลือ & คำถามที่พบบ่อย",
                        subtitle: "ติดต่อฝ่ายสนับสนุน",
                        onTap: () => Get.toNamed(AppRoutes.help),
                      ),
                    ] else ...[
                      // Seller settings
                      _buildSettingsTile(
                        icon: Icons.storefront,
                        title: "ข้อมูลร้านค้า",
                        subtitle: "ชื่อร้าน, โลโก้, ที่อยู่, เวลาทำการ",
                        onTap: () => Get.snackbar('จัดการร้าน', 'ไปหน้าแก้ไขร้าน (mock)'),
                      ),
                      _buildSettingsTile(
                        icon: Icons.category,
                        title: "บริการที่รองรับ",
                        subtitle: "เพิ่ม/แก้ไขวิธีผลิต, ราคาเริ่มต้น",
                        onTap: () => Get.snackbar('บริการ', 'จัดการบริการ (mock)'),
                      ),
                      _buildSettingsTile(
                        icon: Icons.star_outline,
                        title: "รีวิวของร้าน",
                        subtitle: "ดูและตอบรีวิวจากลูกค้า",
                        onTap: () => Get.toNamed(AppRoutes.storeReviews),
                      ),
                      _buildSettingsTile(
                        icon: Icons.notifications_outlined,
                        title: "การแจ้งเตือน",
                        subtitle: "แจ้งเตือนออร์เดอร์ใหม่, ข้อความลูกค้า",
                        onTap: () => Get.toNamed(AppRoutes.notificationsSettings),
                      ),
                      _buildSettingsTile(
                        icon: Icons.security,
                        title: "ความปลอดภัย",
                        subtitle: "เปลี่ยนรหัสผ่าน, 2FA",
                        onTap: () => Get.toNamed(AppRoutes.security),
                      ),
                    ],

                    SizedBox(height: AppSizes.xxl),

                    // ปุ่มออกจากระบบ (ทั้ง buyer/seller)
                    AppButton(
                      label: "ออกจากระบบ",
                      isOutlined: true,
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      textColor: AppColors.error,
                      onPressed: () {
                        Get.find<AppController>().setRole(''); // ลบ role
                        Get.offAllNamed(AppRoutes.login);
                      },
                    ),
                    SizedBox(height: AppSizes.xxl),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 3, // Settings = index 3
        onTap: (index) {
          if (index == 0) Get.offNamed(AppRoutes.home);
          if (index == 1) Get.offNamed(AppRoutes.orders);
          if (index == 2) Get.offNamed(AppRoutes.stores);
          if (index == 3) {} // อยู่แล้ว
        },
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: AppSizes.iconMd),
      title: AppText(title, style: AppTextStyles.bodyLg),
      subtitle: AppText(
        subtitle,
        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}