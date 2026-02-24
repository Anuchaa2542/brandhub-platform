// features/shared/presentation/pages/two_factor_auth_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TwoFactorAuthPage extends StatefulWidget {
  const TwoFactorAuthPage({super.key});

  @override
  State<TwoFactorAuthPage> createState() => _TwoFactorAuthPageState();
}

class _TwoFactorAuthPageState extends State<TwoFactorAuthPage> {
  bool _isEnabled = false; // mock เริ่มต้นปิด

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("การยืนยันตัวตนสองขั้นตอน (2FA)", style: AppTextStyles.h2),
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
                "เพิ่มความปลอดภัยให้บัญชีของคุณ",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เมื่อเปิดใช้งาน คุณจะต้องยืนยันตัวตนด้วยรหัสจากแอป Authenticator หรือ SMS ทุกครั้งที่ล็อกอินจากอุปกรณ์ใหม่",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              SwitchListTile(
                title: AppText("เปิดใช้งาน 2FA", style: AppTextStyles.bodyLg),
                subtitle: AppText(
                  _isEnabled ? "เปิดอยู่" : "ปิดอยู่",
                  style: AppTextStyles.caption.copyWith(color: _isEnabled ? AppColors.success : AppColors.error),
                ),
                value: _isEnabled,
                activeColor: AppColors.accent,
                onChanged: (val) {
                  setState(() => _isEnabled = val);
                  Get.snackbar(
                    'แจ้งเตือน',
                    val ? 'เปิดใช้งาน 2FA แล้ว (mock)' : 'ปิดใช้งาน 2FA แล้ว (mock)',
                  );
                },
              ),
              SizedBox(height: AppSizes.xl),

              if (_isEnabled) ...[
                AppText("วิธีการยืนยันตัวตน", style: AppTextStyles.h3),
                SizedBox(height: AppSizes.sm),
                ListTile(
                  leading: Icon(Icons.phone_android, color: AppColors.primary),
                  title: AppText("แอป Authenticator (แนะนำ)"),
                  subtitle: AppText("Google Authenticator, Authy, Microsoft Authenticator"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Get.snackbar('ตั้งค่า Authenticator', 'สแกน QR Code (mock)'),
                ),
                ListTile(
                  leading: Icon(Icons.sms, color: AppColors.primary),
                  title: AppText("SMS ไปยังเบอร์โทร"),
                  subtitle: AppText("รับรหัส OTP ทางข้อความ"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],

              Spacer(),
              AppButton(
                label: _isEnabled ? "ปิดใช้งาน 2FA" : "เปิดใช้งาน 2FA",
                onPressed: () {
                  setState(() => _isEnabled = !_isEnabled);
                  Get.snackbar('สำเร็จ', _isEnabled ? 'เปิด 2FA แล้ว' : 'ปิด 2FA แล้ว');
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