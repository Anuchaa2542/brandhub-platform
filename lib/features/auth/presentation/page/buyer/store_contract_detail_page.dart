// features/buyer/presentation/pages/contact_store_page.dart
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
import 'package:url_launcher/url_launcher.dart'; // เพิ่ม package นี้ใน pubspec.yaml เพื่อเปิด Line/โทร/เว็บจริง

class ContactStorePage extends StatelessWidget {
  const ContactStorePage({super.key});

  // ฟังก์ชันเปิด URL (Line, โทร, เว็บ)
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('ไม่สามารถเปิดได้', 'กรุณาติดตั้งแอปที่เกี่ยวข้อง (mock fallback)');
    }
  }

  @override
  Widget build(BuildContext context) {
    // รับข้อมูลร้านจาก arguments
    final store = Get.arguments as Map<String, dynamic>? ?? {};

    final name = store['name'] ?? 'ไม่ระบุร้าน';
    final phone = store['phone'] ?? 'ไม่ระบุ';
    final line = store['line'] ?? 'ไม่ระบุ';
    final website = store['website'] ?? 'ไม่ระบุ';
    final address = store['address'] ?? 'ไม่ระบุ';

    // mock เวลาทำการและข้อมูลเพิ่มเติม
    final businessHours = "จันทร์-เสาร์ 09:00 - 18:00 น.\nอาทิตย์หยุด (mock)";
    final responseTime = "ตอบกลับภายใน 15-30 นาที (mock)";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppText("ติดต่อ $name", style: AppTextStyles.h2),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSizes.lg),

              // Header ร้าน
              CircleAvatar(
                radius: 70.r,
                backgroundColor: AppColors.surface,
                backgroundImage: store['logo'] != null ? AssetImage(store['logo']) : null,
                child: store['logo'] == null
                    ? Icon(Icons.store, size: 80.sp, color: AppColors.accent)
                    : null,
              ),
              SizedBox(height: AppSizes.md),
              AppText(name, style: AppTextStyles.h2),
              SizedBox(height: 4.h),
              AppText("พร้อมให้บริการคุณเสมอ", style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
              SizedBox(height: AppSizes.xs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: AppRadius.allMd,
                ),
                child: AppText("ตอบกลับเฉลี่ย $responseTime", style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
              ),
              SizedBox(height: AppSizes.xl * 1.5),

              // ช่องทางการติดต่อหลัก (ใหญ่และเด่น)
              AppText("ติดต่อด่วน", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),

              _buildContactButton(
                icon: Icons.phone,
                label: "โทรศัพท์",
                subtitle: phone,
                color: AppColors.success,
                onPressed: () {
                  final telUrl = 'tel:$phone';
                  _launchUrl(telUrl);
                },
              ),
              SizedBox(height: AppSizes.md),

              _buildContactButton(
                icon: Icons.chat_bubble_outline,
                label: "แชท Line",
                subtitle: "@$line",
                color: AppColors.primary,
                onPressed: () {
                  final lineUrl = 'https://line.me/R/ti/p/~$line';
                  _launchUrl(lineUrl);
                },
              ),
              SizedBox(height: AppSizes.xl),

              // ข้อมูลเพิ่มเติม
              AppText("ข้อมูลร้านค้า", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),

              _buildInfoCard(
                icon: Icons.location_on,
                title: "ที่อยู่ร้าน",
                content: address,
              ),
              _buildInfoCard(
                icon: Icons.language,
                title: "เว็บไซต์",
                content: website,
                onTap: () => _launchUrl(website.startsWith('http') ? website : 'https://$website'),
              ),
              _buildInfoCard(
                icon: Icons.access_time,
                title: "เวลาทำการ",
                content: businessHours,
              ),

              SizedBox(height: AppSizes.xxl),

              // ปุ่มส่งข้อความทั่วไป
              AppButton(
                label: "ส่งข้อความถึงร้าน",
                icon: Icon(Icons.message, color: Colors.white),
                onPressed: () {
                  Get.snackbar(
                    'เปิดแชท',
                    'กำลังเปิดช่องทางการส่งข้อความกับร้าน $name (mock)',
                    duration: const Duration(seconds: 3),
                    
                  );
                  Get.toNamed(AppRoutes.sendMessageToStore, arguments: store); // ส่งข้อมูลร้านไป
                },
              ),
              SizedBox(height: AppSizes.md),

              AppText(
                "หากมีปัญหาเร่งด่วน โปรดโทรหรือแชท Line โดยตรง",
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Column(
        children: [
          AppText(label, style: AppTextStyles.button.copyWith(color: Colors.white)),
          SizedBox(height: 2.h),
          AppText(subtitle, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, AppSizes.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSizes.md),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: AppSizes.iconMd),
        title: AppText(title, style: AppTextStyles.bodyLg),
        subtitle: AppText(content, style: AppTextStyles.bodyMd),
        trailing: onTap != null ? Icon(Icons.open_in_new, color: AppColors.accent) : null,
        onTap: onTap,
      ),
    );
  }
}