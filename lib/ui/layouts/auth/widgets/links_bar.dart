import 'package:dashboard/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinksBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: (Get.width > 1000) ? Get.height * 0.07 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(
            text: 'about',
            onPressed: () => print('About'),
          ),
          LinkText(text: 'Help Center'),
          LinkText(text: 'Term Of service'),
          LinkText(text: 'Privacy policy'),
          LinkText(text: 'Cookie Policy'),
          LinkText(text: 'ads info'),
          LinkText(text: 'blog'),
          LinkText(text: 'status'),
          LinkText(text: 'Careers'),
          LinkText(text: 'Brand Resources'),
          LinkText(text: 'Advertaising'),
          LinkText(text: 'marketing'),
        ],
      ),
    );
  }
}
