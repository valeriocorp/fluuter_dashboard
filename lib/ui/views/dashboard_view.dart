import 'package:dashboard/providers/auth_provider.dart';
import 'package:dashboard/ui/cards/white_card.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboarView extends StatelessWidget {
  final user = Get.find<AuthProvider>().user!;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Dashboard View",
            style: CustomLabel.h1,
          ),
          SizedBox(
            height: 10,
          ),
          WhiteCard(
            title: user.nombre,
            child: Text(user.correo),
          ),
        ],
      ),
    );
  }
}
