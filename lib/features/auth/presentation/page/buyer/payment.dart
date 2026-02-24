// features/buyer/presentation/pages/payment_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_button.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  void _mockPaymentSuccess(BuildContext context, Map<String, dynamic> args) {
    // Auto save slip (mock) - ในชีวิตจริงจะบันทึกใน local storage หรือส่งไป backend
    Get.snackbar(
      'ชำระเงินสำเร็จ',
      'สลิปการชำระเงินถูกบันทึกอัตโนมัติในประวัติออร์เดอร์ของคุณ',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );

    // จำลองบันทึก slip ในประวัติ (mock)
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    final slipData = {
      'orderId': orderId,
      'date': DateTime.now().toString().substring(0, 10),
      'store': args['selectedStore'] ?? 'ไม่ระบุ',
      'amount': args['totalPrice'] ?? 0.0,
      'status': 'ชำระแล้ว',
      'slipSaved': true,
    };

    // ในชีวิตจริงจะบันทึกใน GetStorage หรือ Hive
    print('Auto saved slip: $slipData');

    // ไปหน้า BuyerHome หรือ History
    Get.offAllNamed(AppRoutes.homePage);
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    final total = args['totalPrice'] ?? 0.0;
    final store = args['selectedStore'] ?? 'ไม่ระบุร้าน';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ชำระเงิน", style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment_rounded,
                size: 100.sp,
                color: AppColors.accent,
              ),
              SizedBox(height: AppSizes.xl),
              AppText(
                "ชำระเงินสำหรับออร์เดอร์กับ $store",
                style: AppTextStyles.h2,
                align: TextAlign.center,
              ),
              SizedBox(height: AppSizes.md),
              AppText(
                "ยอดรวมทั้งสิ้น",
                style: AppTextStyles.displaySm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "${total.toStringAsFixed(0)} บาท",
                style: AppTextStyles.displayLg.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.xxl * 1.5),

              AppButton(
                label: "ชำระด้วย PromptPay / QR Code",
                onPressed: () => _mockPaymentSuccess(context, args),
              ),
              SizedBox(height: AppSizes.md),

              AppButton(
                label: "ชำระด้วยบัตรเครดิต / เดบิต",
                isOutlined: true,
                onPressed: () => _mockPaymentSuccess(context, args),
              ),
              SizedBox(height: AppSizes.md),

              AppButton(
                label: "โอนเงินผ่านธนาคาร",
                isOutlined: true,
                onPressed: () => _mockPaymentSuccess(context, args),
              ),
              SizedBox(height: AppSizes.xl),

              AppText(
                "หลังชำระเงินสำเร็จ สลิปจะบันทึกอัตโนมัติในประวัติออร์เดอร์",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                align: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
