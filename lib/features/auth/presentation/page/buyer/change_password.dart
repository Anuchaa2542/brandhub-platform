// features/shared/presentation/pages/change_password_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  void _savePassword() {
    if (_formKey.currentState!.validate()) {
      // Mock การบันทึก
      Get.snackbar(
        'สำเร็จ',
        'เปลี่ยนรหัสผ่านใหม่เรียบร้อยแล้ว',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("เปลี่ยนรหัสผ่าน", style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.lg),
                AppText(
                  "อัปเดตรหัสผ่านใหม่เพื่อความปลอดภัย",
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                ),
                SizedBox(height: AppSizes.xl),

                AppText("รหัสผ่านเดิม", style: AppTextStyles.bodyMd),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: _obscureOld,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureOld ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureOld = !_obscureOld),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'กรุณากรอกรหัสผ่านเดิม' : null,
                ),
                SizedBox(height: AppSizes.lg),

                AppText("รหัสผ่านใหม่", style: AppTextStyles.bodyMd),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNew,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureNew = !_obscureNew),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'กรุณากรอกรหัสผ่านใหม่';
                    if (value.length < 6) return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.lg),

                AppText("ยืนยันรหัสผ่านใหม่", style: AppTextStyles.bodyMd),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                  validator: (value) {
                    if (value != _newPasswordController.text) return 'รหัสผ่านไม่ตรงกัน';
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.xxl * 1.5),

                AppButton(
                  label: "บันทึกรหัสผ่านใหม่",
                  onPressed: _savePassword,
                ),
                SizedBox(height: AppSizes.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}