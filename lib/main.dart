// main.dart (ปรับเต็ม)
import 'package:brandhub/core/themes/app_theme.dart';
import 'package:brandhub/features/auth/presentation/controller/app_controller.dart';
import 'package:brandhub/route/app_page.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BrandHub',
          theme: getAppTheme(),
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          initialBinding: BindingsBuilder(() {
            Get.put(AppController());
          }),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // สำหรับ Web: ขยายเต็มจอจริง ๆ (designSize = ขนาดจอจริง)
                  if (kIsWeb) {
                    ScreenUtil.init(
                      context,
                      designSize: Size(constraints.maxWidth, constraints.maxHeight),
                      minTextAdapt: true,
                    );
                    return child!;
                  }
                  return child!;
                },
              ),
            );
          },
        );
      },
    );
  }
}