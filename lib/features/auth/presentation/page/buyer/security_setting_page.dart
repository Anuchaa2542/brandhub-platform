// features/shared/presentation/pages/security_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ความปลอดภัย", style: AppTextStyles.h2),
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
              AppText("จัดการความปลอดภัยบัญชี", style: AppTextStyles.displaySm),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เปลี่ยนรหัสผ่านและตั้งค่าความปลอดภัยเพิ่มเติม",
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.xl),

              _buildSecurityTile(
                icon: Icons.lock_outline,
                title: "เปลี่ยนรหัสผ่าน",
                subtitle: "อัปเดตรหัสผ่านใหม่เพื่อความปลอดภัย",
                onTap: () {
                  Get.toNamed(AppRoutes.changePassword);
                  Get.snackbar(
                    'เปลี่ยนรหัสผ่าน',
                    'ฟังก์ชันนี้ยังอยู่ในระหว่างพัฒนา (mock)',
                  );
                },
              ),
              _buildSecurityTile(
                icon: Icons.security,
                title: "การยืนยันตัวตนสองขั้นตอน (2FA)",
                subtitle: "เปิดใช้งานเพื่อป้องกันการเข้าถึงโดยไม่ได้รับอนุญาต",
               onTap: () {
                  Get.toNamed(AppRoutes.twoFactorAuth);
                  Get.snackbar(
                    '2FA',
                    'ฟังก์ชันนี้ยังอยู่ในระหว่างพัฒนา (mock)',
                  );
                
               },
              ),
              _buildSecurityTile(
                icon: Icons.devices,
                title: "อุปกรณ์ที่ล็อกอิน",
                subtitle: "ดูและจัดการอุปกรณ์ที่เข้าสู่ระบบ",
                onTap: () {
                  Get.toNamed(AppRoutes.loggedInDevices);
                  Get.snackbar(
                    'อุปกรณ์ที่ล็อกอิน',
                    'ฟังก์ชันนี้ยังอยู่ในระหว่างพัฒนา (mock)',
                  );
                },
              ),
              _buildSecurityTile(
                icon: Icons.logout,
                title: "ออกจากระบบทุกอุปกรณ์",
                subtitle: "ออกจากระบบทั้งหมดยกเว้นอุปกรณ์นี้",
                onTap: () {
                  Get.toNamed(AppRoutes.logoutAllDevices);
                  Get.snackbar(
                    'ออกจากระบบทุกอุปกรณ์',
                    'ฟังก์ชันนี้ยังอยู่ในระหว่างพัฒนา (mock)',
                  );
                },
              ),
              SizedBox(height: AppSizes.xxl),

              AppButton(
                label: "บันทึกการตั้งค่า",
                onPressed: () {
                  Get.snackbar(
                    'สำเร็จ',
                    'การตั้งค่าความปลอดภัยถูกบันทึกแล้ว (mock)',
                  );
                },
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: AppSizes.iconMd),
      title: AppText(title, style: AppTextStyles.bodyLg),
      subtitle: AppText(
        subtitle,
        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
      ),
      trailing:
          trailing ?? Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
