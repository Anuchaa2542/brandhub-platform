// features/buyer/presentation/pages/stores_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_bottom_nav_bar.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoresPage extends StatelessWidget {
  StoresPage({super.key});

  // Mock data ร้านค้าทั้งหมด (hardcode ในหน้า)
  final List<Map<String, dynamic>> mockStores = [
    {
      'name': 'ร้านสกรีนด่วน สยาม',
      'rating': 4.8,
      'reviews': 245,
      'description': 'สกรีนเร็ว คุณภาพสูง ทุกวิธี DTG/DTF/Silk',
      'highlight': 'ส่งด่วนภายใน 3 วัน',
      'address': 'สยามสแควร์ ซอย 1, กรุงเทพฯ',
      'phone': '02-123-4567',
      'line': '@screenduan',
      'website': 'www.screenduan.com',
      'logo': 'assets/store_logo/siam.png', // เปลี่ยนเป็น path จริง
      'services': ['DTG', 'DTF', 'Silk Screen', 'UV Printing'],
      'minOrder': 'เริ่มต้น 20 ตัว',
      'delivery': '3-7 วันทำการ',
    },
    {
      'name': 'PrintMaster Bangkok',
      'rating': 4.6,
      'reviews': 189,
      'description': 'ราคาถูก เหมาะกับงานจำนวนมาก',
      'highlight': 'ฟรี neck label ทุกออร์เดอร์',
      'address': 'บางนา-ตราด กม. 10, กรุงเทพฯ',
      'phone': '081-987-6543',
      'line': '@printmasterbkk',
      'website': 'printmasterbkk.com',
      'logo': 'assets/store_logo/printmaster.png',
      'services': ['DTG', 'DTF', 'Silk', 'Heat Transfer'],
      'minOrder': 'เริ่มต้น 50 ตัว',
      'delivery': '5-10 วันทำการ',
    },
    // เพิ่มร้านอื่น ๆ ตาม mock เดิม...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false, // ไม่มีปุ่ม back
        title: AppText("ร้านค้า", style: AppTextStyles.h2),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.lg),
              AppText("ร้านค้าที่แนะนำ", style: AppTextStyles.displaySm),
              SizedBox(height: AppSizes.sm),
              AppText(
                "เลือกดูร้านที่คุณสนใจ หรือค้นหาตามความต้องการ",
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.xl),

              Expanded(
                child: ListView.builder(
                  itemCount: mockStores.length,
                  itemBuilder: (context, index) {
                    final store = mockStores[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: AppSizes.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.allMd,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(AppSizes.md),
                        leading: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: AppColors.surface,
                          backgroundImage: store['logo'] != null
                              ? AssetImage(store['logo'])
                              : null,
                          child: store['logo'] == null
                              ? Icon(
                                  Icons.store,
                                  size: 30.sp,
                                  color: AppColors.accent,
                                )
                              : null,
                        ),
                        title: AppText(
                          store['name'],
                          style: AppTextStyles.bodyLg,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            SizedBox(height: 4.h),
                            AppText(
                              store['description'],
                              style: AppTextStyles.bodyMd,
                            ),
                            SizedBox(height: 4.h),
                            AppText(
                              store['highlight'],
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColors.accent,
                        ),
                        onTap: () {
                          // ส่งข้อมูลร้านไปหน้า detail
                          Get.toNamed(AppRoutes.storeDetail, arguments: store);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2, // สมมติว่า Stores เป็น index 2
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(AppRoutes.homePage);
          } else if (index == 1) {
            Get.toNamed(AppRoutes.orders);
          } else if (index == 2) {
          } else if (index == 3) {
            Get.toNamed(AppRoutes.settings);
          }
        },
      ),
    );
  }
}
