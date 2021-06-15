import 'package:dashboard/providers/auth_provider.dart';
import 'package:dashboard/providers/sidebar_provider.dart';
import 'package:dashboard/ui/views/blank_view.dart';
import 'package:dashboard/ui/views/categories_view.dart';
import 'package:dashboard/ui/views/dashboard_view.dart';
import 'package:dashboard/ui/views/icons_view.dart';
import 'package:dashboard/ui/views/login_view.dart';
import 'package:dashboard/ui/views/register_view.dart';
import 'package:dashboard/ui/views/user_view.dart';
import 'package:dashboard/ui/views/users_view.dart';
import 'package:get/get.dart';
part 'router.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGINROUTE,
      page: () => (redirect('')) ? LoginView() : DashboarView(),
      transition: Transition.fadeIn,
      transitionDuration: 200.milliseconds,
    ),
    GetPage(
      name: Routes.REGISTERROUTE,
      page: () => (redirect('')) ? RegisterView() : DashboarView(),
      transition: Transition.fadeIn,
      transitionDuration: 200.milliseconds,
    ),
    GetPage(
        name: Routes.DASBOARDROUTE,
        page: () =>
            (redirect(Routes.DASBOARDROUTE)) ? LoginView() : DashboarView(),
        transition: Transition.fadeIn,
        transitionDuration: 200.milliseconds),
    GetPage(
        name: Routes.ICONSROUTE,
        page: () => (redirect(Routes.ICONSROUTE)) ? LoginView() : IconsView(),
        transition: Transition.fadeIn,
        transitionDuration: 200.milliseconds),
    GetPage(
        name: Routes.BLANKROUTE,
        page: () => (redirect(Routes.BLANKROUTE)) ? LoginView() : BlankView(),
        transition: Transition.fadeIn,
        transitionDuration: 200.milliseconds),
    GetPage(
        name: Routes.CATEGORIESROUTE,
        page: () =>
            (redirect(Routes.CATEGORIESROUTE)) ? LoginView() : CategoriesView(),
        transition: Transition.fadeIn,
        transitionDuration: 200.milliseconds),
    GetPage(
        name: Routes.USERSROUTE,
        page: () => (redirect(Routes.USERSROUTE)) ? LoginView() : UsersView(),
        transition: Transition.fadeIn,
        transitionDuration: 200.milliseconds),
    GetPage(
        name: Routes.USERROUTE,
        page: () => (redirect(Routes.USERROUTE))
            ? LoginView()
            : (uid(Routes.USERROUTE))
                ? UserView(uid: Get.parameters['uid']!)
                : UsersView(),
        transition: Transition.fadeIn,
        transitionDuration: 200.milliseconds),
  ];
}

bool redirect(String routeName) {
  final authController = Get.find<AuthProvider>();
  final sideBarProvider = Get.find<SideBarProvider>();
  if (authController.authStatus.value == AuthStatus.notAuthenticated) {
    sideBarProvider.setCurrentPageUrl(routeName);
    return true;
  } else {
    sideBarProvider.setCurrentPageUrl(routeName);
    return false;
  }
}

bool uid(String routeName) {
  print(Get.parameters['uid']);
  return true;
}
