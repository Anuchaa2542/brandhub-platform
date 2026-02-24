// features/buyer/presentation/pages/product_selection_page.dart
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

class ProductSelectionPage extends StatefulWidget {
  const ProductSelectionPage({super.key});

  @override
  State<ProductSelectionPage> createState() => _ProductSelectionPageState();
}

class _ProductSelectionPageState extends State<ProductSelectionPage> {
  // ตัวแปรเก็บการเลือกทีละขั้น (สามารถเก็บเป็น Map หรือ List ได้)
  String? selectedCategory;     // ชั้น 1: เสื้อผ้า, แก้ว, ร่ม ฯลฯ
  String? selectedSubCategory;  // ชั้น 2: เสื้อ, กางเกง, หมวก
  String? selectedType;         // ชั้น 3: เสื้อยืด, sweatpants, ฯลฯ
  String? selectedStyle;        // ชั้น 4: oversize, cotton, ฯลฯ

  // ข้อมูลหมวดหมู่แบบ mock (สามารถดึงจาก backend หรือ Firestore ได้)
  final Map<String, List<String>> categories = {
    'เสื้อผ้า': ['เสื้อ', 'กางเกง', 'เสื้อกันหนาว', 'ชุดออกกำลังกาย'],
    'เสื้อ': ['เสื้อยืด', 'เสื้อโปโล', 'เสื้อแขนยาว', 'เสื้อกีฬา'],
    'เสื้อยืด': ['Oversize', 'Regular Fit', 'Cotton 100%', 'Boxer'],
    'กางเกง': ['Sweatpants', 'กางเกงขาสั้น', 'กางเกงยีนส์'],
    'หมวก': ['Snapback', 'Bucket Hat', 'Trucker Cap'],
    'อื่น ๆ': ['รองเท้าแตะ', 'แก้วน้ำ', 'ร่ม', 'ถุงผ้า'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("เลือกประเภทสินค้า", style: AppTextStyles.h2),
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
                "เลือกสินค้าที่ต้องการสกรีน",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เลือกทีละขั้นตอน เพื่อให้ได้สินค้าที่ตรงใจที่สุด",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              // แสดงการเลือกปัจจุบัน (breadcrumb)
              _buildBreadcrumb(),
              SizedBox(height: AppSizes.lg),

              // เนื้อหาหลัก: แสดงตัวเลือกตามขั้นตอนปัจจุบัน
              Expanded(
                child: _buildSelectionList(),
              ),

              // ปุ่มถัดไป / ยืนยัน
              if (selectedStyle != null || selectedCategory == 'อื่น ๆ') ...[
                AppButton(
                  label: "ดำเนินการต่อ (เลือกวิธีสกรีน)",
                  onPressed: () {
                    // เก็บข้อมูลที่เลือกแล้วไปหน้าถัดไป (เช่น screen method)
                    Get.toNamed(AppRoutes.screenMethodSelection, arguments: {
                      'category': selectedCategory,
                      'subCategory': selectedSubCategory,
                      'type': selectedType,
                      'style': selectedStyle,
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

  Widget _buildBreadcrumb() {
    List<String> crumbs = [];
    if (selectedCategory != null) crumbs.add(selectedCategory!);
    if (selectedSubCategory != null) crumbs.add(selectedSubCategory!);
    if (selectedType != null) crumbs.add(selectedType!);
    if (selectedStyle != null) crumbs.add(selectedStyle!);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: crumbs.asMap().entries.map((e) {
          int index = e.key;
          String text = e.value;
          return Row(
            children: [
              if (index > 0) Icon(Icons.chevron_right, size: 20.sp, color: AppColors.textSecondary),
              AppText(
                text,
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.primary),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectionList() {
    List<String> options = [];

    if (selectedStyle != null) {
      // ถ้าเลือกถึงชั้นสุดท้ายแล้ว แสดงสรุปหรือปุ่มถัดไป
      return Center(
        child: AppText(
          "เลือกเสร็จสิ้น: $selectedStyle\nพร้อมไปขั้นตอนถัดไป",
          style: AppTextStyles.bodyLg,
          align: TextAlign.center,
        ),
      );
    } else if (selectedType != null) {
      options = categories[selectedType!] ?? [];
    } else if (selectedSubCategory != null) {
      options = categories[selectedSubCategory!] ?? [];
    } else if (selectedCategory != null) {
      options = categories[selectedCategory!] ?? [];
    } else {
      options = categories.keys.toList(); // ชั้นแรก
    }

    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final item = options[index];
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd, side: BorderSide(color: AppColors.divider)),
          child: ListTile(
            title: AppText(item, style: AppTextStyles.bodyLg),
            trailing: Icon(Icons.chevron_right, color: AppColors.accent),
            onTap: () {
              setState(() {
                if (selectedCategory == null) {
                  selectedCategory = item;
                } else if (selectedSubCategory == null) {
                  selectedSubCategory = item;
                } else if (selectedType == null) {
                  selectedType = item;
                } else if (selectedStyle == null) {
                  selectedStyle = item;
                }
              });
            },
          ),
        );
      },
    );
  }
}