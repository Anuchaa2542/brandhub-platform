// features/auth/presentation/controllers/login_controller.dart
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginWithEmail() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // จำลอง delay

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'กรุณากรอกอีเมลและรหัสผ่าน', backgroundColor: Colors.red);
      isLoading.value = false;
      return;
    }

    // Mock success ทุกครั้ง (ไม่เช็คจริง)
    Get.snackbar('Success (Mock)', 'เข้าสู่ระบบสำเร็จ', backgroundColor: Colors.green);
    Get.offAllNamed(AppRoutes.homePage); // ไปหน้า buyer home ทันที

    isLoading.value = false;
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    Get.snackbar('Success (Mock)', 'เข้าสู่ระบบด้วย Google สำเร็จ');
    Get.offAllNamed(AppRoutes.homePage);
    isLoading.value = false;
  }

  Future<void> signInWithApple() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    Get.snackbar('Success (Mock)', 'เข้าสู่ระบบด้วย Apple สำเร็จ');
    Get.offAllNamed(AppRoutes.homePage);
    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}