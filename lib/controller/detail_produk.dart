import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProdukController extends GetxController {
  var loading = false.obs;
  var selectedImageTop = 0.obs;

  final pageController = PageController();
  final listPenilaian = <Map>[
    {
      'author': 'Maude Hall',
      'time': '${Random().nextInt(60)} min',
      'rating': '${(Random().nextDouble() * 5).ceilToDouble()}',
      'comment': "That's a fantastic new app feature. You and your team did an excellent job of incorporating user testing feedback.",
      'image': 'assets/images/people1.png'
    },
    {
      'author': 'Ester Howard',
      'time': '${Random().nextInt(60)} min',
      'rating': '${(Random().nextDouble() * 5).ceilToDouble()}',
      'comment': "That's a fantastic new app feature. You and your team did an excellent job of incorporating user testing feedback.",
      'image': 'assets/images/people2.png'
    }
  ];

  getSomething() async {
    loading(true);
    await Future.delayed(Duration(seconds: 1));
    loading(false);
  }

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