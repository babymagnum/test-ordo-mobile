import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ordo_mobile/utils/helper/constant.dart';
import 'package:test_ordo_mobile/view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Test Ordo Mobile',
      home: HomeScreen(),
      // initialRoute: Routes.HOME,
      // getPages: [
      //   GetPage(name: Routes.HOME, page: () => HomeScreen()),
      // ],
      debugShowCheckedModeBanner: false,
    );
  }

}
