// features/buyer/presentation/pages/store_selection_page.dart
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

class StoreSelectionPage extends StatefulWidget {
  const StoreSelectionPage({super.key});

  @override
  State<StoreSelectionPage> createState() => _StoreSelectionPageState();
}

class _StoreSelectionPageState extends State<StoreSelectionPage> {
  late Map<String, dynamic> args;
  String selectedStore = '';

  // รับค่าจาก arguments
  String get productType => args['product']?.toString() ?? 'ไม่ระบุสินค้า';
  String get screenMethod =>
      args['screenMethod']?.toString() ?? 'ไม่ระบุวิธีผลิต';
  int get quantity => args['quantity'] as int? ?? 50;
  double get totalPrice => (args['totalPrice'] as num?)?.toDouble() ?? 0.0;
  Map<String, bool> get packages =>
      (args['packages'] as Map?)?.cast<String, bool>() ?? {};

  // Mock ร้านค้า (เพิ่ม pricePerUnit และ total คำนวณจริง)
  final List<Map<String, dynamic>> stores = [
    {
      'name': 'ร้านสกรีนด่วน สยาม',
      'rating': 4.8,
      'reviews': 245,
      'basePricePerUnit': 115.0,
      'deliveryTime': '3-5 วัน',
      'distance': '2.5 กม.',
      'supports': ['DTG', 'DTF', 'Silk Screen'],
      'logo': 'assets/store_logo/siam.png',
      'highlight': 'ส่งด่วน + ฟรี thank you card',
    },
    {
      'name': 'PrintMaster Bangkok',
      'rating': 4.6,
      'reviews': 189,
      'basePricePerUnit': 105.0,
      'deliveryTime': '5-7 วัน',
      'distance': '5.8 กม.',
      'supports': ['DTG', 'DTF', 'UV', 'Silk'],
      'logo': 'assets/store_logo/printmaster.png',
      'highlight': 'ราคาถูกที่สุดสำหรับงาน 50+ ตัว',
    },
    {
      'name': 'InkFactory Factory Outlet',
      'rating': 4.9,
      'reviews': 320,
      'basePricePerUnit': 120.0,
      'deliveryTime': '4-6 วัน',
      'distance': '8.1 กม.',
      'supports': ['DTF', 'DFT', 'Silk'],
      'logo': 'assets/store_logo/inkfactory.png',
      'highlight': 'คุณภาพพรีเมียม + ฟรี neck label',
    },
    {
      'name': 'CustomPrint Chiang Mai',
      'rating': 4.7,
      'reviews': 112,
      'basePricePerUnit': 98.0,
      'deliveryTime': '7-10 วัน',
      'distance': 'ออนไลน์ (ส่งพัสดุ)',
      'supports': ['DTG', 'DTF', 'UV'],
      'logo': 'assets/store_logo/customprint.png',
      'highlight': 'ถูกที่สุด แต่ส่งช้ากว่า',
    },
  ];

  @override
  void initState() {
    super.initState();
    args = Get.arguments as Map<String, dynamic>? ?? {};
    if (args.isEmpty) {
      Get.snackbar(
        'แจ้งเตือน',
        'ข้อมูลออร์เดอร์ไม่ครบ (mock default)',
        backgroundColor: Colors.orange,
      );
    }
  }

  // คำนวณราคารวมของแต่ละร้านตาม quantity + packages
  double calculateStoreTotal(double basePricePerUnit) {
    double total = quantity * basePricePerUnit;

    // เพิ่มราคา package (mock logic)
    if (packages['logoScreen'] == true) total += 10 * quantity;
    if (packages['thankYouCard'] == true) total += 5 * quantity;
    if (packages['sticker'] == true) total += 3 * quantity;
    if (packages['neckLabel'] == true) total += 8 * quantity;

    return total;
  }

  @override
  Widget build(BuildContext context) {
    // คำนวณ total ใหม่สำหรับแต่ละร้าน
    final storesWithTotal = stores.map((store) {
      final base = store['basePricePerUnit'] as double;
      final total = calculateStoreTotal(base);
      return {...store, 'total': total};
    }).toList();

    final cheapestPrice = storesWithTotal
        .map((s) => s['total'] as double)
        .reduce((a, b) => a < b ? a : b);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: AppText("เลือกร้าน & เปรียบเทียบราคา", style: AppTextStyles.h2),
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
              AppText("สรุปออร์เดอร์ของคุณ", style: AppTextStyles.displaySm),
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
                    _buildSummaryRow("สินค้า", productType),
                    _buildSummaryRow("วิธีผลิต/สกรีน", screenMethod),
                    _buildSummaryRow("จำนวน", "$quantity ตัว"),
                    if (packages.isNotEmpty) ...[
                      AppText(
                        "Package เพิ่มเติม:",
                        style: AppTextStyles.caption,
                      ),
                      ...packages.entries
                          .where((e) => e.value)
                          .map(
                            (e) => AppText(
                              "• ${e.key}",
                              style: AppTextStyles.caption,
                            ),
                          ),
                    ],
                    SizedBox(height: 12.h),
                    _buildSummaryRow(
                      "ราคารวม (ประมาณ)",
                      "${totalPrice.toStringAsFixed(0)} บาท",
                      highlight: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xl),

              AppText("ร้านที่รองรับงานนี้", style: AppTextStyles.h3),
              SizedBox(height: AppSizes.sm),
              AppText(
                "คัดร้านที่รองรับ $screenMethod และจำนวน $quantity ตัว",
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.lg),

              // List ร้านค้า
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: storesWithTotal.length,
                itemBuilder: (context, index) {
                  final store = storesWithTotal[index];
                  final isSelected = selectedStore == store['name'];
                  final isCheapest =
                      (store['total'] as double) == cheapestPrice;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStore = store['name'];
                      });
                    },
                    child: Card(
                      elevation: isSelected ? 6 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.allMd,
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.divider,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: AppRadius.allMd,
                                    color: AppColors.surface,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.store,
                                      size: 30.sp,
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ),
                                SizedBox(width: AppSizes.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppText(
                                            store['name'],
                                            style: AppTextStyles.h3,
                                          ),
                                          if (isCheapest)
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: AppSizes.xs,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 2.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green.withOpacity(
                                                  0.1,
                                                ),
                                                borderRadius: AppRadius.allXs,
                                              ),
                                              child: AppText(
                                                "ถูกที่สุด",
                                                style: AppTextStyles.caption
                                                    .copyWith(
                                                      color: Colors.green,
                                                    ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16.sp,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(width: 4.w),
                                          AppText(
                                            "${store['rating']} (${store['reviews']} รีวิว)",
                                            style: AppTextStyles.caption,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: AppColors.accent,
                                    size: 24.sp,
                                  ),
                              ],
                            ),
                            SizedBox(height: AppSizes.md),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      "ราคาต่อตัว",
                                      style: AppTextStyles.caption,
                                    ),
                                    AppText(
                                      "${(store['basePricePerUnit'] as double).toStringAsFixed(0)} บาท",
                                      style: AppTextStyles.h4.copyWith(
                                        color: AppColors.accent,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AppText(
                                      "รวมทั้งหมด",
                                      style: AppTextStyles.caption,
                                    ),
                                    AppText(
                                      "${(store['total'] as double).toStringAsFixed(0)} บาท",
                                      style: AppTextStyles.h4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: AppSizes.sm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_shipping,
                                      size: 16.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                    SizedBox(width: 4.w),
                                    AppText(
                                      store['deliveryTime'],
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                    SizedBox(width: 4.w),
                                    AppText(
                                      store['distance'],
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: AppSizes.sm),
                            AppText(
                              "จุดเด่น: ${store['highlight']}",
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSizes.xl),

              if (selectedStore.isNotEmpty) ...[
                AppButton(
                  label: "เลือก $selectedStore → สรุป & ชำระเงิน",
                  onPressed: () {
                    final selected = storesWithTotal.firstWhere(
                      (s) => s['name'] == selectedStore,
                    );
                    Get.toNamed(
                      AppRoutes.orderSummary,
                      arguments: {
                        'product': productType,
                        'screenMethod': screenMethod,
                        'quantity': quantity,
                        'totalPrice': totalPrice,
                        'selectedStore': selectedStore,
                        'storeData': selected,
                        'packages': packages,
                      },
                    );
                  },
                ),
                SizedBox(height: AppSizes.md),
              ] else ...[
                Center(
                  child: AppText(
                    "กรุณาเลือกร้านก่อนดำเนินการต่อ",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
              SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool highlight = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppText(
            value,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
              color: highlight ? AppColors.accent : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
