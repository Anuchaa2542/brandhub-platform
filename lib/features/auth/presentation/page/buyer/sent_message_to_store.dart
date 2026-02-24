// features/buyer/presentation/pages/send_message_to_store_page.dart
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/features/auth/presentation/controller/buyer_controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SendMessageToStorePage extends StatelessWidget {
  const SendMessageToStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Get.arguments as Map<String, dynamic>? ?? {};
    final name = store['name'] ?? 'ไม่ระบุร้าน';

    final ChatController controller = Get.put(ChatController());

    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.surface,
              child: Icon(Icons.store, size: 24.sp, color: AppColors.accent),
            ),
            SizedBox(width: AppSizes.sm),
            AppText("แชทกับ $name", style: AppTextStyles.h2),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ประวัติแชท (ListView reverse เพื่อให้ข้อความล่าสุดอยู่ล่าง)
          Expanded(
            child: Obx(() => ListView.builder(
                  reverse: true, // ข้อความใหม่อยู่ล่าง
                  padding: EdgeInsets.all(AppSizes.md),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[controller.messages.length - 1 - index]; // reverse index
                    final isMe = msg['isMe'];
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.accent : AppColors.surface,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isMe ? 16.r : 0),
                            topRight: Radius.circular(isMe ? 0 : 16.r),
                            bottomLeft: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            AppText(
                              msg['text'],
                              style: AppTextStyles.bodyMd.copyWith(
                                color: isMe ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            AppText(
                              msg['time'],
                              style: AppTextStyles.caption.copyWith(
                                color: isMe ? Colors.white70 : AppColors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),

          // พื้นที่พิมพ์ + ส่ง
          Container(
            padding: EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: "พิมพ์ข้อความ...",
                      hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.allLg,
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.sm),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.accent, size: 28.sp),
                  onPressed: () {
                    final text = messageController.text.trim();
                    if (text.isNotEmpty) {
                      controller.sendMessage(text);
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}