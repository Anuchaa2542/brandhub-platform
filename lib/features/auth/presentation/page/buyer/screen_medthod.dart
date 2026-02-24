// features/buyer/presentation/pages/screen_method_selection_page.dart
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

class ScreenMethodSelectionPage extends StatefulWidget {
  const ScreenMethodSelectionPage({super.key});

  @override
  State<ScreenMethodSelectionPage> createState() => _ScreenMethodSelectionPageState();
}

class _ScreenMethodSelectionPageState extends State<ScreenMethodSelectionPage> {
  String? selectedMethod;

  // ข้อมูลวิธีสกรีนแบบ mock (สามารถดึงจาก backend หรือ Firestore ได้)
  final List<Map<String, dynamic>> screenMethods = [
    {
      'name': 'DTG (Direct to Garment)',
      'description': 'พิมพ์สีเต็มรูปแบบ คุณภาพสูง เหมาะกับลายสีสันเยอะ',
      'bestFor': 'เสื้อยืด, ผ้าฝ้าย, สีเข้ม-อ่อนได้หมด',
      'priceRange': 'สูง (80-150 บาท/ตัว)',
      'minOrder': '30+ ตัว',
      'icon': Icons.print,
      'color': Colors.blue,
    },
    {
      'name': 'DTF (Direct to Film)',
      'description': 'ถ่ายโอนลายจากฟิล์ม คุณภาพดี ทนทาน ซักได้ดี',
      'bestFor': 'เสื้อผ้าทุกประเภท, กางเกง, หมวก, แก้ว',
      'priceRange': 'กลาง (50-120 บาท/ตัว)',
      'minOrder': '20+ ตัว',
      'icon': Icons.layers,
      'color': Colors.purple,
    },
    {
      'name': 'DFT (Direct Film Transfer)',
      'description': 'คล้าย DTF แต่ใช้ฟิล์มพิเศษ ทนทานสูงมาก',
      'bestFor': 'งานที่ต้องการความทนทานสูง เช่น กางเกงออกกำลังกาย',
      'priceRange': 'สูง (70-140 บาท/ตัว)',
      'minOrder': '50+ ตัว',
      'icon': Icons.transfer_within_a_station,
      'color': Colors.teal,
    },
    {
      'name': 'สกรีนซิลค์สกรีน (Silk Screen)',
      'description': 'แบบดั้งเดิม ราคาถูกเมื่อสั่งจำนวนมาก',
      'bestFor': 'งานจำนวนมาก ลายเรียบง่าย 1-4 สี',
      'priceRange': 'ต่ำ-กลาง (20-80 บาท/ตัว)',
      'minOrder': '100+ ตัว',
      'icon': Icons.grid_on,
      'color': Colors.orange,
    },
    {
      'name': 'UV Printing',
      'description': 'พิมพ์ตรงบนวัสดุแข็ง เช่น แก้ว, ร่ม',
      'bestFor': 'แก้วน้ำ, ร่ม, โลหะ',
      'priceRange': 'สูง (100-200 บาท/ชิ้น)',
      'minOrder': '10+ ชิ้น',
      'icon': Icons.lightbulb,
      'color': Colors.amber,
    },
    {
      'name': 'อื่น ๆ / ขอใบเสนอราคา',
      'description': 'วิธีพิเศษอื่น ๆ หรือต้องการให้ร้านแนะนำ',
      'bestFor': 'งาน custom ทุกประเภท',
      'priceRange': 'ตามที่ร้านเสนอ',
      'minOrder': 'ตามที่ตกลง',
      'icon': Icons.more_horiz,
      'color': Colors.grey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // รับข้อมูลจากหน้าที่แล้ว (product selection)
    final arguments = Get.arguments as Map<String, dynamic>?;
    final selectedProduct = arguments?['style'] ?? arguments?['type'] ?? 'สินค้าที่เลือก';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("เลือกวิธีสกรีน", style: AppTextStyles.h2),
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
                "วิธีสกรีนสำหรับ $selectedProduct",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เลือกวิธีที่เหมาะกับงานและงบประมาณของคุณ",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              // แสดงการเลือกสินค้าจากหน้าก่อนหน้า (breadcrumb)
              Container(
                padding: EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.allMd,
                  border: Border.all(color: AppColors.divider),
                ),
                child: AppText(
                  "สินค้าที่เลือก: $selectedProduct",
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.primary),
                ),
              ),
              SizedBox(height: AppSizes.lg),

              // List วิธีสกรีน
              Expanded(
                child: ListView.builder(
                  itemCount: screenMethods.length,
                  itemBuilder: (context, index) {
                    final method = screenMethods[index];
                    final isSelected = selectedMethod == method['name'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMethod = method['name'];
                        });
                      },
                      child: Card(
                        elevation: isSelected ? 4 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.allMd,
                          side: BorderSide(
                            color: isSelected ? AppColors.accent : AppColors.divider,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppSizes.md),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: method['color'].withOpacity(0.1),
                                  borderRadius: AppRadius.allMd,
                                ),
                                child: Icon(
                                  method['icon'],
                                  color: method['color'],
                                  size: 28.sp,
                                ),
                              ),
                              SizedBox(width: AppSizes.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      method['name'],
                                      style: AppTextStyles.h3.copyWith(
                                        color: isSelected ? AppColors.accent : AppColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    AppText(
                                      method['description'],
                                      style: AppTextStyles.bodyMd,
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        AppText("เหมาะกับ: ", style: AppTextStyles.caption),
                                        AppText(method['bestFor'], style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(method['priceRange'], style: AppTextStyles.caption.copyWith(color: Colors.green)),
                                        AppText("ขั้นต่ำ ${method['minOrder']}", style: AppTextStyles.caption),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: AppColors.accent, size: 24.sp),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ปุ่มถัดไป
              if (selectedMethod != null) ...[
                SizedBox(height: AppSizes.lg),
                AppButton(
                  label: "เลือกวิธีนี้ → วาง layout ถัดไป",
                  onPressed: () {
                    // ส่งข้อมูลไปหน้าถัดไป (Layout Design)
                    Get.toNamed(AppRoutes.layoutDesign, arguments: {
                      'product': selectedProduct,
                      'screenMethod': selectedMethod,
                      // สามารถส่งข้อมูลเพิ่มเติมได้
                    });
                  },
                ),
                SizedBox(height: AppSizes.md),
              ],
            ],
          ),
        ),
      ),
    );
  }
}