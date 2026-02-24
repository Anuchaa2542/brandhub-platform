// core/controllers/app_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {
  final RxString role = ''.obs; // 'buyer' or 'seller'
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    role.value = box.read('role') ?? 'buyer'; // default buyer
  }

  void setRole(String newRole) {
    role.value = newRole;
    box.write('role', newRole);
  }
}