import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeController extends GetxController {
  final PersistentTabController tabController = PersistentTabController(initialIndex: 2);

  var page = 2.obs;
  var pagesClicked = <int>[
    2
  ];

  addPages(int value) {
    if (pagesClicked.last == value) return;

    pagesClicked.add(value);

    print('HomeController $pagesClicked');
  }

  removePages() {
    pagesClicked.removeLast();

    print('HomeController $pagesClicked');

    page(pagesClicked.last);
  }
}