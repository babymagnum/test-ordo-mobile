import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test_ordo_mobile/utils/theme/theme_text_style.dart';

class BaseView extends StatelessWidget {
  final bool isUseAppbar;
  final String? title;
  final Widget? appbarContent;
  final Widget? appbarLeading;
  final Widget child;

  BaseView({this.isUseAppbar:false, this.title, this.appbarContent, this.appbarLeading, required this.child});

  @override
  Widget build(BuildContext context) {
    Widget _appBar = AppBar(
      centerTitle: true,
      title: appbarContent ?? Text(title ?? '', style: ThemeTextStyle.poppinsBold.copyWith(fontSize: 29.57, color: Color(0xff64A1F4))),
      leading: appbarLeading ?? GestureDetector(
        onTap: () => Get.back(),
        child: SvgPicture.asset('assets/images/back_button.svg'),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFe5e5e5).withOpacity(0.1),
      appBar: isUseAppbar ? _appBar as PreferredSizeWidget? : null,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
