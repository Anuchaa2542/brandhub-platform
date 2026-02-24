// features/auth/presentation/pages/login_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/features/auth/presentation/controller/login_controller.dart';
import 'package:brandhub/features/auth/presentation/widget/app_text_field.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.screenPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppSizes.xl),

                Icon(
                  Icons.storefront,
                  color: AppColors.primary,
                  size: AppSizes.iconLg * 2,
                ),
                SizedBox(height: AppSizes.md),

                AppText(
                  "Welcome to BrandHub",
                  style: AppTextStyles.displaySm,
                  align: TextAlign.center,
                ),
                SizedBox(height: AppSizes.sm),

                AppText(
                  "Login to continue",
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  align: TextAlign.center,
                ),

                SizedBox(height: AppSizes.xl * 1.5),

                // ← Fixed: use DynamicTextField (not the enum!)
                DynamicTextField(
                  mode: DynamicTextFieldMode.textField,
                  label: "", // or "อีเมล" if you want label
                  hintText: "Email",
                  controller: controller.emailController,
                  borderColor: AppColors.border,
                  keyboardType: TextInputType.emailAddress,
                  showCounter: false,
                  suffixIcon: Icon(Icons.email, color: AppColors.textSecondary),
                ),
                SizedBox(height: AppSizes.md),

                DynamicTextField(
                  mode: DynamicTextFieldMode.textField,

                  label: "", // or "รหัสผ่าน" if you want label
                  hintText: "Password",
                  controller: controller.passwordController,

                  obscureText: true,
                  showCounter: false,
                  // You can add: keyboardType: TextInputType.visiblePassword,
                ),

                SizedBox(height: AppSizes.lg),

                Obx(
                  () => AppButton(
                    label: "Login",
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      // เรียก login จริง (ถ้ามี logic) ก่อน แล้วค่อย navigate
                      controller.loginWithEmail(); // ถ้ามี logic login อยู่แล้ว

                      // หรือ mock ตรงนี้เลย
                      Get.toNamed(AppRoutes.homePage); // ใช้ toNamed เสมอ
                    },
                  ),
                ),

                SizedBox(height: AppSizes.md),

                TextButton(
                  onPressed: () {
                    // Get.toNamed(AppRoutes.register);
                  },
                  child: AppText(
                    "Create Account",
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.md),

                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                      child: AppText(
                        "OR",
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: AppSizes.md),

                AppButton(
                  label: "Continue with Google",
                  isOutlined: true,
                  icon: Icon(
                    Icons.g_mobiledata,
                    size: AppSizes.iconMd,
                    color: AppColors.primary,
                  ),
                  onPressed: controller.signInWithGoogle,
                ),

                SizedBox(height: AppSizes.sm),

                AppButton(
                  label: "Continue with Apple",
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  icon: Icon(
                    Icons.apple,
                    size: AppSizes.iconMd,
                    color: Colors.white,
                  ),
                  onPressed: controller.signInWithApple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
