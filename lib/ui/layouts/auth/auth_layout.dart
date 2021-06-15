import 'package:dashboard/ui/layouts/auth/widgets/background_twitter.dart';
import 'package:dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:dashboard/ui/layouts/auth/widgets/links_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        //  isAlwaysShown: true,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            (Get.width > 1000)
                //Desktop
                ? _DesktopBody(child: child)
                //Mobile
                : _MobileBody(child: child),

            //LinkBar
            LinksBar()
          ],
        ),
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;
  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          Container(
            height: 400,
            width: double.infinity,
            child: BackgroundTwitter(),
          ),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.95,
      color: Colors.black,
      child: Row(
        children: [
          //twitter background

          Expanded(child: BackgroundTwitter()),
          //view container
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTitle(),
                SizedBox(
                  height: 50,
                ),
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
