import 'package:dashboard/api/CafeApi.dart';
import 'package:dashboard/providers/auth_provider.dart';
import 'package:dashboard/providers/categories_provider.dart';
import 'package:dashboard/providers/user_form_provider.dart';
import 'package:dashboard/providers/users_provider.dart';
import 'package:dashboard/router/pages.dart';
import 'package:dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:dashboard/ui/views/no_page_found_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'providers/sidebar_provider.dart';

void main() async {
  await GetStorage.init();
  CafeApi.configureDio();
  runApp(MyApp());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SideBarProvider sideBarProvider = Get.put(SideBarProvider());
    final AuthProvider authProvider = Get.put(AuthProvider());
    Get.put(UsersProvider());
    Get.put(CategoriesProvider());
    Get.put(UserFormProvider());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin dahsboard',
      initialRoute: (Get.put<AuthProvider>(AuthProvider()).authStatus.value ==
              AuthStatus.notAuthenticated)
          ? Routes.LOGINROUTE
          : Routes.DASBOARDROUTE,
      getPages: AppPages.pages,
      unknownRoute: GetPage(
          name: '/notfound',
          page: () {
            sideBarProvider.setCurrentPageUrl('404');
            return NoPageFound();
          }),
      navigatorKey: Get.key,
      builder: (_, child) {
        return GetBuilder<AuthProvider>(
            init: authProvider,
            builder: (__) {
              if (__.authStatus.value == AuthStatus.checking)
                return SplashLayout();

              if (__.authStatus.value == AuthStatus.authenticated) {
                return DashboarLayout(child: child!);
              } else {
                return AuthLayout(child: child!);
              }
            });
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(
        Colors.grey.withOpacity(0.6),
      ))),
    );
  }
}
