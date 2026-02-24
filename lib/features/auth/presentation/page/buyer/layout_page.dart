// features/buyer/presentation/pages/layout_design_page.dart
import 'dart:io';
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
import 'package:image_picker/image_picker.dart';

class LayoutDesignPage extends StatefulWidget {
  const LayoutDesignPage({super.key});

  @override
  State<LayoutDesignPage> createState() => _LayoutDesignPageState();
}

class _LayoutDesignPageState extends State<LayoutDesignPage> {
  // ข้อมูลจากหน้าที่แล้ว
  late Map<String, dynamic> args;
  String get productType => args['style'] ?? args['type'] ?? 'เสื้อยืด';

  // ตัวแปรสำหรับ layout
  File? uploadedImage;
  String selectedPosition = 'หน้าอกตรงกลาง'; // default
  double imageScale = 1.0;
  Offset imageOffset = Offset.zero;

  // ตำแหน่งที่รองรับ (สามารถเพิ่ม/ปรับได้)
  final List<String> positions = [
    'หน้าอกตรงกลาง',
    'หน้าอกซ้าย',
    'หน้าอกขวา',
    'หลังกลาง',
    'แขนซ้าย',
    'แขนขวา',
    'Tag คอ (ด้านใน)',
    'Tag เสื้อ (ด้านล่าง)',
    'Tag กางเกง (ด้านใน)',
  ];

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        uploadedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    args = Get.arguments as Map<String, dynamic>? ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("ออกแบบ Layout สกรีน", style: AppTextStyles.h2),
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
                "ออกแบบการสกรีนสำหรับ $productType",
                style: AppTextStyles.displaySm,
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "อัปโหลดโลโก้/รูป แล้วจัดวางตำแหน่งตามต้องการ",
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.xl),

              // Preview Area (ตัวอย่างสินค้าพร้อม overlay รูป)
              Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.allLg,
                  border: Border.all(color: AppColors.divider),
                  image: const DecorationImage(
                    image: AssetImage('assets/mockup/tshirt_mockup.png'), // เปลี่ยนเป็น asset mockup ของคุณ
                    fit: BoxFit.contain,
                  ),
                ),
                child: uploadedImage != null
                    ? GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            imageOffset += details.delta;
                          });
                        },
                        child: Transform.translate(
                          offset: imageOffset,
                          child: Transform.scale(
                            scale: imageScale,
                            child: Image.file(
                              uploadedImage!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: AppText(
                          "ยังไม่มีรูปอัปโหลด\nแตะเพื่อเลือกตำแหน่ง",
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                          align: TextAlign.center,
                        ),
                      ),
              ),
              SizedBox(height: AppSizes.md),

              // Slider ปรับขนาด
              if (uploadedImage != null) ...[
                AppText("ปรับขนาด", style: AppTextStyles.bodyLg),
                Slider(
                  value: imageScale,
                  min: 0.5,
                  max: 2.0,
                  divisions: 30,
                  label: imageScale.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      imageScale = value;
                    });
                  },
                  activeColor: AppColors.accent,
                ),
                SizedBox(height: AppSizes.md),
              ],

              // เลือกตำแหน่ง
              AppText("เลือกตำแหน่งสกรีน", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),
              Wrap(
                spacing: AppSizes.sm,
                runSpacing: AppSizes.sm,
                children: positions.map((pos) {
                  final isSelected = selectedPosition == pos;
                  return FilterChip(
                    label: AppText(pos, style: AppTextStyles.bodyMd),
                    selected: isSelected,
                    selectedColor: AppColors.accent.withOpacity(0.2),
                    checkmarkColor: AppColors.accent,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          selectedPosition = pos;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: AppSizes.xl),

              // อัปโหลดรูป
              AppButton(
                label: uploadedImage == null ? "อัปโหลดโลโก้ / รูปภาพ" : "เปลี่ยนรูป",
                isOutlined: true,
                onPressed: _pickImage,
                icon: Icon(Icons.upload_file, color: AppColors.primary),
              ),
              SizedBox(height: AppSizes.lg),

              // สรุปและดำเนินการต่อ
              if (uploadedImage != null) ...[
                AppButton(
                  label: "ยืนยัน layout → เลือกจำนวน & Package",
                  onPressed: () {
                    Get.toNamed(AppRoutes.quantityPackage, arguments: {
                      'product': productType,
                      'screenMethod': args['screenMethod'],
                      'layoutPosition': selectedPosition,
                      'imagePath': uploadedImage?.path,
                      // สามารถส่งข้อมูลเพิ่ม เช่น scale, offset ถ้าต้องการบันทึก
                    });
                  },
                ),
                SizedBox(height: AppSizes.md),
              ] else ...[
                AppText(
                  "กรุณาอัปโหลดรูปก่อนดำเนินการต่อ",
                  style: AppTextStyles.caption.copyWith(color: AppColors.error),
                  align: TextAlign.center,
                ),
              ],
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}