import 'package:get/get.dart';

import '../modules/bottom_navigation.dart/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation.dart/views/bottom_navigation_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/change_password/bindings/change_password_bindings.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/edit_account/bindings/edit_account_binding.dart';
import '../modules/edit_account/views/edit_account.dart';
import '../modules/forget_password/bindings/forget_password_bindings.dart';
import '../modules/forget_password/views/forget_pass_otp.dart';
import '../modules/forget_password/views/forget_pass_set_pass.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_showcase/bindings/home_showcase_binding.dart';
import '../modules/home_showcase/views/home_showcase_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/more/bindings/more_binding.dart';
import '../modules/more/views/about_us_view.dart';
import '../modules/more/views/contact_us_view.dart';
import '../modules/more/views/more_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/complete_account_residence.dart';
import '../modules/registration/views/complete_account_work.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/registration/views/set_password_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/start_service/bindings/start_service_binding.dart';
import '../modules/start_service/views/url_service_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.SETPASSWORD,
      page: () => const SetPasswordView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETEACCOUNT,
      page: () => const CompleteAccountView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETEACCOUNTWORK,
      page: () => const CompleteAccountWorkView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.EditACCOUNT,
      page: () => const EditAccountView(isEdit: true),
      binding: EditAccountBinding(),
    ),
    GetPage(
      name: _Paths.ViewACCOUNT,
      page: () => const EditAccountView(
        isEdit: false,
      ),
      binding: EditAccountBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.URLSERVICE,
      page: () => const URLServiceView(),
      binding: StartServiceBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSOTP,
      page: () => const ForgetPassOtpView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSSETPASS,
      page: () => const ForgetPassSetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
        name: _Paths.BOTTOMNAVIGATION,
        page: () => const BottomNavigationView(),
        binding: BottomNavigationBinding(),
        children: [
          GetPage(
            name: _Paths.HOME,
            page: () => const HomeView(),
            binding: HomeBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.MORE,
      page: () => const MoreView(),
      binding: MoreBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => const AboutUsView(),
    ),
    GetPage(
      name: _Paths.CONTACTUS,
      page: () => const ContactUsView(),
    ),
    GetPage(
      name: _Paths.HOME_SHOWCASE,
      page: () => const HomeShowcaseView(),
      binding: HomeShowcaseBinding(),
    ),
  ];
}
