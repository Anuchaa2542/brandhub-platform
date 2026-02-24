// features/buyer/presentation/controllers/buyer_home_controller.dart
import 'package:brandhub/features/auth/presentation/page/buyer/buyer_homepage.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/order_bottom.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/setting.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyerHomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  // หน้าในแต่ละ tab (ใช้ StatelessWidget หรือ StatefulWidget ได้)
  final List<Widget> tabPages = [
    BuyerHomePage(), // Tab 0: หน้าแรก (เนื้อหาหลักเดิม)
    OrdersPage(), // Tab 1: ออร์เดอร์
    StoresPage(), // Tab 2: ร้านค้า
    const SettingsPage(), // Tab 3: โปรไฟล์
  ];
}
