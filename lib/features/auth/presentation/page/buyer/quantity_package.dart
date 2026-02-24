// features/buyer/presentation/pages/quantity_package_page.dart
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

class QuantityPackagePage extends StatefulWidget {
  const QuantityPackagePage({super.key});

  @override
  State<QuantityPackagePage> createState() => _QuantityPackagePageState();
}

class _QuantityPackagePageState extends State<QuantityPackagePage> {
  late Map<String, dynamic> args;

  String get productType => args['style'] ?? args['type'] ?? args['product'] ?? 'เสื้อยืด';
  String get screenMethod => args['screenMethod'] ?? 'ไม่ระบุ';
  String get layoutPosition => args['layoutPosition'] ?? 'ไม่ระบุ';
  bool get isOEM => args['isOEM'] ?? false; // ใช้ในอนาคตถ้ามาจาก OEM flow

  int quantity = 50;
  int minOrder = 30; // จะปรับตาม screenMethod หรือ isOEM ได้
  bool includeLogoScreen = false;
  bool includeThankYouCard = false;
  bool includeSticker = false;
  bool includeNeckLabel = false;

  // เพิ่มตัวเลือกพิเศษสำหรับ OEM (mock)
  bool includeSpecialMaterial = false;
  bool includeDesignService = false;

  // ราคา mock (ปรับตาม isOEM ได้)
  double get basePricePerUnit => isOEM ? 180.0 : 120.0; // OEM แพงกว่า
  double get totalBasePrice => quantity * basePricePerUnit;
  double get extraPackagePrice {
    double extra = 0;
    if (includeLogoScreen) extra += 10.0 * quantity;
    if (includeThankYouCard) extra += 5.0 * quantity;
    if (includeSticker) extra += 3.0 * quantity;
    if (includeNeckLabel) extra += 8.0 * quantity;

    // เพิ่มสำหรับ OEM
    if (includeSpecialMaterial) extra += 30.0 * quantity;
    if (includeDesignService) extra += 1500.0; // ค่าออกแบบครั้งเดียว

    return extra;
  }
  double get totalPrice => totalBasePrice + extraPackagePrice;

  @override
  void initState() {
    super.initState();
    args = Get.arguments as Map<String, dynamic>? ?? {};

    // ปรับ minOrder ตามประเภท (mock)
    if (isOEM) {
      minOrder = 100; // OEM มักขั้นต่ำสูงกว่า
    } else if (screenMethod == 'Silk Screen') {
      minOrder = 100;
    } else if (screenMethod == 'DTG') {
      minOrder = 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("จำนวน & Package เพิ่มเติม", style: AppTextStyles.h2),
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
                "สรุป${isOEM ? 'การผลิต OEM' : 'สินค้า & วิธีสกรีน'}",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              Container(
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.allMd,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText("สินค้า: $productType", style: AppTextStyles.bodyLg),
                    SizedBox(height: 4.h),
                    AppText("วิธีผลิต/สกรีน: $screenMethod", style: AppTextStyles.bodyMd),
                    if (!isOEM) SizedBox(height: 4.h),
                    if (!isOEM) AppText("ตำแหน่ง: $layoutPosition", style: AppTextStyles.bodyMd),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xl),

              // จำนวน
              AppText("จำนวนที่ต้องการสั่ง", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: AppColors.primary),
                    onPressed: () {
                      if (quantity > minOrder) setState(() => quantity--);
                    },
                  ),
                  Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    child: AppText(
                      "$quantity ตัว",
                      style: AppTextStyles.h2.copyWith(color: AppColors.accent),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: AppColors.primary),
                    onPressed: () => setState(() => quantity++),
                  ),
                  SizedBox(width: AppSizes.md),
                  AppText(
                    "(ขั้นต่ำ $minOrder ตัว)",
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.xl),

              // Package & เพิ่มเติม
              AppText("Package & ตัวเลือกเพิ่มเติม", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),

              _buildPackageOption(
                title: "สกรีนโลโก้เพิ่ม (Screen Logo)",
                description: "เพิ่มโลโก้ขนาดเล็กทุกชิ้น",
                price: "+10 บาท/ชิ้น",
                value: includeLogoScreen,
                onChanged: (val) => setState(() => includeLogoScreen = val!),
              ),
              _buildPackageOption(
                title: "Thank You Card แบบ customize",
                description: "การ์ดขอบคุณออกแบบเอง",
                price: "+5 บาท/ใบ",
                value: includeThankYouCard,
                onChanged: (val) => setState(() => includeThankYouCard = val!),
              ),
              _buildPackageOption(
                title: "สติกเกอร์ customize",
                description: "สติกเกอร์ติดสินค้า/กล่อง",
                price: "+3 บาท/ชิ้น",
                value: includeSticker,
                onChanged: (val) => setState(() => includeSticker = val!),
              ),
              _buildPackageOption(
                title: "ป้ายคอเสื้อ (Neck Label)",
                description: "ป้ายรายละเอียดภายในคอ",
                price: "+8 บาท/ชิ้น",
                value: includeNeckLabel,
                onChanged: (val) => setState(() => includeNeckLabel = val!),
              ),

              // ตัวเลือกพิเศษสำหรับ OEM
              if (isOEM) ...[
                SizedBox(height: AppSizes.lg),
                AppText("ตัวเลือกเพิ่มเติมสำหรับ OEM", style: AppTextStyles.h3),
                _buildPackageOption(
                  title: "วัสดุพิเศษ (Organic Cotton, Recycled)",
                  description: "เลือกวัสดุพรีเมียม",
                  price: "+20-50 บาท/ชิ้น",
                  value: includeSpecialMaterial,
                  onChanged: (val) => setState(() => includeSpecialMaterial = val!),
                ),
                _buildPackageOption(
                  title: "บริการออกแบบโดยร้าน",
                  description: "ให้ร้านออกแบบให้ตามไอเดีย",
                  price: "+1,500 บาท (ครั้งเดียว)",
                  value: includeDesignService,
                  onChanged: (val) => setState(() => includeDesignService = val!),
                ),
              ],

              SizedBox(height: AppSizes.xl),

              // สรุปราคา
              Container(
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.allMd,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText("สรุปค่าใช้จ่าย", style: AppTextStyles.h3),
                    SizedBox(height: AppSizes.md),
                    _buildPriceRow("ราคาต่อชิ้น", "${basePricePerUnit.toStringAsFixed(0)} บาท"),
                    _buildPriceRow("ราคารวมสินค้า", "${totalBasePrice.toStringAsFixed(0)} บาท"),
                    if (extraPackagePrice > 0)
                      _buildPriceRow("Package & เพิ่มเติม", "+${extraPackagePrice.toStringAsFixed(0)} บาท"),
                    Divider(height: 24.h),
                    _buildPriceRow("ยอดรวมทั้งหมด", "${totalPrice.toStringAsFixed(0)} บาท", isTotal: true),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xl),

              AppButton(
                label: "ต่อไป → เลือกร้าน & เปรียบเทียบราคา",
                onPressed: () {
                  Get.toNamed(AppRoutes.storeSelection, arguments: {
                    'product': productType,
                    'screenMethod': screenMethod,
                    'quantity': quantity,
                    'totalPrice': totalPrice,
                    'packages': {
                      'logoScreen': includeLogoScreen,
                      'thankYouCard': includeThankYouCard,
                      'sticker': includeSticker,
                      'neckLabel': includeNeckLabel,
                      if (isOEM) 'specialMaterial': includeSpecialMaterial,
                      if (isOEM) 'designService': includeDesignService,
                    },
                    'isOEM': isOEM,
                  });
                },
              ),
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageOption({
    required String title,
    required String description,
    required String price,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      title: AppText(title, style: AppTextStyles.bodyLg),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(description, style: AppTextStyles.caption),
          AppText(price, style: AppTextStyles.caption.copyWith(color: Colors.green)),
        ],
      ),
      value: value,
      activeColor: AppColors.accent,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(label, style: isTotal ? AppTextStyles.h3 : AppTextStyles.bodyLg),
          AppText(
            value,
            style: isTotal
                ? AppTextStyles.h3.copyWith(color: AppColors.accent, fontWeight: FontWeight.bold)
                : AppTextStyles.bodyLg,
          ),
        ],
      ),
    );
  }
}