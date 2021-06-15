import 'package:dashboard/providers/sidebar_provider.dart';
import 'package:dashboard/ui/shared/widgets/notification_indicator.dart';
import 'package:dashboard/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/navbar_avatar.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (Get.width <= 700)
            IconButton(
              onPressed: () => SideBarProvider.openMenu(),
              icon: Icon(Icons.menu_outlined),
            ),
          SizedBox(
            width: 5,
          ),
          if (Get.width > 440)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 250,
              ),
              child: SearchText(),
            ),
          Spacer(),
          NotificationIndicator(),
          SizedBox(
            width: 10,
          ),
          NavbarAvatar(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
