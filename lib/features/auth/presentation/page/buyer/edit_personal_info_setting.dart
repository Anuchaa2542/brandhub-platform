// features/shared/presentation/pages/edit_personal_info_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart' show AppRadius;
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPersonalInfoPage extends StatefulWidget {
  const EditPersonalInfoPage({super.key});

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  // Mock ข้อมูลเดิม (hardcode) - ในชีวิตจริงจะดึงจาก state หรือ controller
  final TextEditingController _nameController = TextEditingController(text: 'Chazilla');
  final TextEditingController _emailController = TextEditingController(text: 'chazilla@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '081-234-5678');
  final TextEditingController _addressController = TextEditingController(
    text: '123 ถนนสุขุมวิท แขวงคลองเตย เขตคลองเตย กรุงเทพฯ 10110',
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Mock การบันทึก (ในชีวิตจริงจะส่งไป backend หรือบันทึกใน local storage)
      Get.snackbar(
        'สำเร็จ',
        'ข้อมูลส่วนตัวถูกอัปเดตแล้ว',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      Get.back(); // กลับไปหน้าก่อนหน้า
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("แก้ไขข้อมูลส่วนตัว", style: AppTextStyles.h2),
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

                // Avatar (แก้ไขรูปได้ mock)
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: AppColors.surface,
                            child: Icon(Icons.person, size: 80.sp, color: AppColors.textSecondary),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: AppColors.accent,
                              child: Icon(Icons.camera_alt, size: 20.sp, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.sm),
                      AppText("เปลี่ยนรูปโปรไฟล์", style: AppTextStyles.caption.copyWith(color: AppColors.accent)),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.xl * 1.5),

                // ฟอร์มแก้ไข
                AppText("ชื่อ-นามสกุล", style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'กรุณากรอกชื่อ-นามสกุล';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.lg),

                AppText("อีเมล", style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'กรุณากรอกอีเมล';
                    }
                    if (!value.contains('@')) {
                      return 'รูปแบบอีเมลไม่ถูกต้อง';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.lg),

                AppText("เบอร์โทรศัพท์", style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'กรุณากรอกเบอร์โทรศัพท์';
                    }
                    if (value.length < 9) {
                      return 'เบอร์โทรไม่ถูกต้อง';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.lg),

                AppText("ที่อยู่จัดส่ง", style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: AppRadius.allMd),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'กรุณากรอกที่อยู่';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.xxl * 1.5),

                // ปุ่มบันทึก
                AppButton(
                  label: "บันทึกการเปลี่ยนแปลง",
                  onPressed: _saveChanges,
                ),
                SizedBox(height: AppSizes.md),

                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: AppText("ยกเลิก", style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
                  ),
                ),
                SizedBox(height: AppSizes.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}