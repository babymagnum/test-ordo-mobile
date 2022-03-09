import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ordo_mobile/model/product.dart';

class DashboardController extends GetxController {
  final pageController = PageController();
  final listImageTop = [
    'assets/images/dashboard_image_top.png',
    'assets/images/dashboard_image_top.png',
    'assets/images/dashboard_image_top.png',
  ];

  final listProduct = [
    Product([
      'assets/images/image 1.png',
      'assets/images/image 1.png',
      'assets/images/image 1.png',
    ], 'Product 1', 6000, 4500, 10, 1, 3.7, 300, Color(0xff92D274).withOpacity(0.27), false, Random().nextInt(130), Random().nextInt(1000), true),
    Product([
      'assets/images/image 2.png',
      'assets/images/image 2.png',
      'assets/images/image 2.png',
    ], 'Product 2', 6000, 4500, 8, 2, 3.7, 300, Color(0xff64A1F4), false, Random().nextInt(130), Random().nextInt(1000), false),
    Product([
      'assets/images/image 3.png',
      'assets/images/image 3.png',
      'assets/images/image 3.png',
    ], 'Product 3', 6000, 4500, 0, 3, 3.7, 300, Color(0xff92D274).withOpacity(0.27), false, Random().nextInt(130), Random().nextInt(1000), false),
    Product([
      'assets/images/image 4.png',
      'assets/images/image 4.png',
      'assets/images/image 4.png',
    ], 'Product 4', 6000, 4500, 15, 4, 3.7, 300, Color(0xff92D274).withOpacity(0.27), false, Random().nextInt(130), Random().nextInt(1000), true),
    Product([
      'assets/images/image 5.png',
      'assets/images/image 5.png',
      'assets/images/image 5.png',
    ], 'Product 5', 6000, 4500, 25, 5, 3.7, 300, Color(0xffDFAE1D), false, Random().nextInt(130), Random().nextInt(1000), false),
    Product([
      'assets/images/image 6.png',
      'assets/images/image 6.png',
      'assets/images/image 6.png',
    ], 'Product 6', 6000, 4500, 0, 6, 3.7, 300, Color(0xff92D274).withOpacity(0.27), true, Random().nextInt(130), Random().nextInt(1000), false),
    Product([
      'assets/images/image 7.png',
      'assets/images/image 7.png',
      'assets/images/image 7.png',
    ], 'Product 7', 6000, 4500, 0, 7, 3.7, 300, Color(0xff92D274).withOpacity(0.27), true, Random().nextInt(130), Random().nextInt(1000), false),
    Product([
      'assets/images/image 8.png',
      'assets/images/image 8.png',
      'assets/images/image 8.png',
    ], 'Product 8', 6000, 4500, 30, 8, 3.7, 300, Color(0xff92D274).withOpacity(0.27), true, Random().nextInt(130), Random().nextInt(1000), false),
  ];

  var selectedImageTop = 0.obs;

  @override
  void onReady() {
    pageController.addListener(() {
      selectedImageTop((pageController.page ?? 0).toInt());
    });

    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }
}