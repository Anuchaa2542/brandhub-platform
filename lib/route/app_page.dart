// routes/app_pages.dart
import 'package:brandhub/features/auth/presentation/controller/buyer_controller/chat_controller.dart';
import 'package:brandhub/features/auth/presentation/controller/login_controller.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/buyer_homepage.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/change_password.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/download_slip.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/edit_personal_info_setting.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/help_setting_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/language_setting.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/layout_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/logged_out_all_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/loggedin_device_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/notification_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/notification_setting.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/oem_design_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/oem_product_on_select.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/order_bottom.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/order_detail_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/order_summary.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/payment.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/persona_info_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/produc_section.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/quantity_package.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/screen_medthod.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/security_setting_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/sent_message_to_store.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/sevice_type_selection.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_contract_detail_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_page_detail.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_review.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_selection.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/store_service_page.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/two_factor_auth_.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/write_review.dart';
import 'package:brandhub/features/auth/presentation/page/login.dart';
import 'package:brandhub/features/auth/presentation/page/buyer/setting.dart';
import 'package:brandhub/features/splash.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.productSelection,
      page: () => const ProductSelectionPage(),
    ),

    GetPage(
      name: AppRoutes.screenMethodSelection,
      page: () => const ScreenMethodSelectionPage(),
    ),
    GetPage(name: AppRoutes.layoutDesign, page: () => const LayoutDesignPage()),
    GetPage(
      name: AppRoutes.quantityPackage,
      page: () => const QuantityPackagePage(),
    ),
    GetPage(
      name: AppRoutes.storeSelection,
      page: () => const StoreSelectionPage(),
    ),
    GetPage(name: AppRoutes.orderSummary, page: () => const OrderSummaryPage()),
    GetPage(name: AppRoutes.homePage, page: () => BuyerHomePage()),
    GetPage(name: AppRoutes.payment, page: () => const PaymentPage()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),

    GetPage(name: AppRoutes.orders, page: () => OrdersPage()),
    GetPage(name: AppRoutes.stores, page: () => StoresPage()),
    GetPage(name: AppRoutes.notifications, page: () => NotificationsPage()),
    GetPage(name: AppRoutes.personalInfo, page: () => const PersonalInfoPage()),
    GetPage(
      name: AppRoutes.notificationsSettings,
      page: () => const NotificationsSettingsPage(),
    ),
    GetPage(name: AppRoutes.language, page: () => LanguagePage()),
    GetPage(name: AppRoutes.security, page: () => const SecurityPage()),
    GetPage(name: AppRoutes.help, page: () => HelpPage()),
    GetPage(
      name: AppRoutes.personalInfoEdit,
      page: () => const EditPersonalInfoPage(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordPage(),
    ),
    GetPage(
      name: AppRoutes.twoFactorAuth,
      page: () => const TwoFactorAuthPage(),
    ),
    GetPage(name: AppRoutes.loggedInDevices, page: () => LoggedInDevicesPage()),
    GetPage(
      name: AppRoutes.logoutAllDevices,
      page: () => const LogoutAllDevicesPage(),
    ),
    GetPage(name: AppRoutes.orderDetail, page: () => const OrderDetailPage()),
    GetPage(name: AppRoutes.storeDetail, page: () => const StoreDetailPage()),
    GetPage(name: AppRoutes.storeReviews, page: () => const StoreReviewsPage()),
    GetPage(name: AppRoutes.contactStore, page: () => const ContactStorePage()),
    GetPage(
      name: AppRoutes.storeServices,
      page: () => const StoreServicesPage(),
    ),
    GetPage(
      name: AppRoutes.sendMessageToStore,
      page: () => const SendMessageToStorePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChatController>(() => ChatController());
      }),
    ),
    GetPage(
      name: AppRoutes.downloadReceipt,
      page: () => const DownloadReceiptPage(),
    ),
    GetPage(name: AppRoutes.writeReview, page: () => const WriteReviewPage()),
    GetPage(
      name: AppRoutes.uploadOemDesign,
      page: () => const UploadOemDesignPage(),
    ),
    GetPage(
      name: AppRoutes.oemProductSelection,
      page: () => OEMProductSelectionPage(),
    ),
    GetPage(
      name: AppRoutes.serviceTypeSelection,
      page: () => const ServiceTypeSelectionPage(),
    ),
  ];
}
