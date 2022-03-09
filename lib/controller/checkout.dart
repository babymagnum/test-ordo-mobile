import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var listCheckout = <Map>[
    {
      'id': '1',
      'title': 'Tas Gucci',
      'price': 75000,
      'buy': 1,
      'catatan': null,
      'image': 'assets/images/image 8.png',
    },
    {
      'id': '2',
      'title': 'Tas Eiger',
      'price': 75000,
      'buy': 1,
      'catatan': null,
      'image': 'assets/images/image 6.png'
    }
  ].obs;
}