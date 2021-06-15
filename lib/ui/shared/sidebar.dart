import 'package:dashboard/providers/auth_provider.dart';
import 'package:dashboard/providers/sidebar_provider.dart';
import 'package:dashboard/router/pages.dart';
import 'package:dashboard/ui/shared/widgets/logo.dart';
import 'package:dashboard/ui/shared/widgets/menu_item.dart';
import 'package:dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  final SideBarProvider sideBarProvider = Get.find<SideBarProvider>();
  void navegateTo(String routeName) {
    Get.offNamed(routeName);
    Get.back();
    SideBarProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 200,
      decoration: buildBoxDecoration(),
      child: Obx(() => ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Logo(),
              SizedBox(
                height: 50,
              ),
              TextSeparator(text: 'main'),
              MenuItem(
                isActive: sideBarProvider.currentPage == Routes.DASBOARDROUTE,
                text: 'Dashboard',
                icon: Icons.compass_calibration_outlined,
                onPressed: () => navegateTo(Routes.DASBOARDROUTE),
              ),
              MenuItem(
                text: 'Orders',
                icon: Icons.shopping_cart_outlined,
                onPressed: () {},
              ),
              MenuItem(
                text: 'Analytic',
                icon: Icons.show_chart_outlined,
                onPressed: () {},
              ),
              MenuItem(
                isActive: sideBarProvider.currentPage == Routes.CATEGORIESROUTE,
                text: 'Categories',
                icon: Icons.layers_clear_outlined,
                onPressed: () => navegateTo(Routes.CATEGORIESROUTE),
              ),
              MenuItem(
                text: 'Products',
                icon: Icons.dashboard_outlined,
                onPressed: () {},
              ),
              MenuItem(
                text: 'Discount',
                icon: Icons.attach_money_outlined,
                onPressed: () {},
              ),
              MenuItem(
                isActive: sideBarProvider.currentPage == Routes.USERSROUTE,
                text: 'Users',
                icon: Icons.people_alt_outlined,
                onPressed: () => navegateTo(Routes.USERSROUTE),
              ),
              SizedBox(
                height: 30,
              ),
              TextSeparator(text: 'UI elements'),
              MenuItem(
                isActive: sideBarProvider.currentPage == Routes.ICONSROUTE,
                text: 'Icons',
                icon: Icons.list_alt_outlined,
                onPressed: () => navegateTo(Routes.ICONSROUTE),
              ),
              MenuItem(
                text: 'Marketing',
                icon: Icons.mark_email_read_outlined,
                onPressed: () {},
              ),
              MenuItem(
                text: 'Campaign',
                icon: Icons.note_add_outlined,
                onPressed: () {},
              ),
              MenuItem(
                isActive: sideBarProvider.currentPage == Routes.BLANKROUTE,
                text: 'Blank',
                icon: Icons.post_add_outlined,
                onPressed: () => navegateTo(Routes.BLANKROUTE),
              ),
              SizedBox(
                height: 30,
              ),
              TextSeparator(text: 'Exit'),
              MenuItem(
                text: 'LogOut',
                icon: Icons.exit_to_app_outlined,
                onPressed: () {
                  Get.find<AuthProvider>().logout();
                },
              ),
            ],
          )),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff092044),
            Color(0xff092042),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      );
}
