import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ordo_mobile/utils/helper/constant.dart';
import 'package:test_ordo_mobile/view/home.dart';
import 'package:test_ordo_mobile/view/niceso.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GetMaterialApp(
      title: 'Test Ordo Mobile',
      navigatorKey: Get.key,
      initialRoute: Routes.HOME,
      getPages: [
        GetPage(name: Routes.HOME, page: () => HomeScreen()),
        GetPage(name: Routes.NICESO, page: () => NicesoScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
