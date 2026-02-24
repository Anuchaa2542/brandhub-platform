// features/buyer/presentation/controllers/review_controller.dart
import 'package:get/get.dart';

class ReviewController extends GetxController {
  // รีวิวทั้งหมด (แยกตามร้านด้วย Map<String, List>)
  final RxMap<String, RxList<Map<String, dynamic>>> reviewsByStore = <String, RxList<Map<String, dynamic>>>{}.obs;

  void addReview({
    required String storeName,
    required double rating,
    required String comment,
    required String user,
  }) {
    if (!reviewsByStore.containsKey(storeName)) {
      reviewsByStore[storeName] = <Map<String, dynamic>>[].obs;
    }

    reviewsByStore[storeName]!.add({
      'user': user,
      'rating': rating,
      'date': 'ตอนนี้',
      'comment': comment,
      'images': [], // mock ถ้ามีรูป
    });
  }

  // ดึงรีวิวของร้านใดร้านหนึ่ง
  List<Map<String, dynamic>> getReviews(String storeName) {
    return reviewsByStore[storeName]?.value ?? [];
  }
}