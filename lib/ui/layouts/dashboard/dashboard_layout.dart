import 'package:dashboard/providers/sidebar_provider.dart';
import 'package:dashboard/ui/shared/navbar.dart';
import 'package:dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboarLayout extends StatefulWidget {
  final Widget child;
  const DashboarLayout({Key? key, required this.child}) : super(key: key);

  @override
  _DashboarLayoutState createState() => _DashboarLayoutState();
}

class _DashboarLayoutState extends State<DashboarLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SideBarProvider.menuController =
        new AnimationController(vsync: this, duration: 300.milliseconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              if (Get.width >= 700) Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    Navbar(),
                    Expanded(
                        child: Container(
                      child: widget.child,
                    )),
                  ],
                ),
              ),
            ],
          ),
          if (Get.width < 700)
            AnimatedBuilder(
              animation: SideBarProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  if (SideBarProvider.isOpen.value)
                    Opacity(
                      opacity: SideBarProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () => SideBarProvider.closeMenu(),
                        child: Container(
                            width: Get.width,
                            height: Get.height,
                            color: Colors.black26),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(SideBarProvider.movement.value, 0),
                    child: Sidebar(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
