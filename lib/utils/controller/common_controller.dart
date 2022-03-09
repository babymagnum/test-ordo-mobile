import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_ordo_mobile/utils/helper/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

class CommonController extends GetxController {

  var notConnected = false.obs;
  var language = Constant.INDONESIAN.obs;
  SharedPreferences? preferences;

  checkConnection() async{
    var _check = await GetConnect().get('https://google.com');

    if(_check.statusCode == 200) {
      notConnected.value = false;
    }else{
      notConnected.value = true;
    }
  }

  setLanguage(BuildContext context, String value) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString(Constant.LANGUANGE_CODE, value);
    language.value = value;
    Get.updateLocale(Locale(language.value));
  }

  initValue() async {
    preferences = await SharedPreferences.getInstance();
  }

  loadLanguage(BuildContext context) async {
    language.value = preferences?.getString(Constant.LANGUANGE_CODE) ?? Constant.INDONESIAN;
    initializeDateFormatting(language.value, null);
    Get.updateLocale(Locale(language.value));
  }
}