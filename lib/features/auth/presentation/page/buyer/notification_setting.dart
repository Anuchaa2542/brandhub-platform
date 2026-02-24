// features/shared/presentation/pages/notifications_settings_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() => _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool orderUpdates = true;
  bool promotions = true;
  bool newMessages = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("การแจ้งเตือน", style: AppTextStyles.h2),
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
                "จัดการการแจ้งเตือน",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เลือกประเภทการแจ้งเตือนที่คุณต้องการรับ",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              _buildSwitchTile(
                title: "แจ้งเตือนแบบ Push",
                subtitle: "รับแจ้งเตือนบนมือถือแม้ปิดแอป",
                value: pushNotifications,
                onChanged: (val) => setState(() => pushNotifications = val!),
              ),
              _buildSwitchTile(
                title: "แจ้งเตือนทางอีเมล",
                subtitle: "รับอัปเดตผ่านอีเมล",
                value: emailNotifications,
                onChanged: (val) => setState(() => emailNotifications = val!),
              ),
              Divider(height: 32.h),

              AppText("แจ้งเตือนประเภท", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.md),
              _buildSwitchTile(
                title: "อัปเดตสถานะออร์เดอร์",
                subtitle: "แจ้งเมื่อออร์เดอร์เปลี่ยนสถานะ",
                value: orderUpdates,
                onChanged: (val) => setState(() => orderUpdates = val!),
              ),
              _buildSwitchTile(
                title: "โปรโมชั่นและข้อเสนอพิเศษ",
                subtitle: "รับข่าวสารส่วนลดและแคมเปญใหม่",
                value: promotions,
                onChanged: (val) => setState(() => promotions = val!),
              ),
              _buildSwitchTile(
                title: "ข้อความใหม่จากร้านค้า",
                subtitle: "แจ้งเมื่อร้านส่งข้อความ",
                value: newMessages,
                onChanged: (val) => setState(() => newMessages = val!),
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return SwitchListTile(
      title: AppText(title, style: AppTextStyles.bodyLg),
      subtitle: AppText(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
      value: value,
      activeColor: AppColors.accent,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}