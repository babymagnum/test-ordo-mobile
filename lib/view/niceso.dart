import 'package:flutter/material.dart';
import 'package:test_ordo_mobile/view/base_view.dart';

class NicesoScreen extends StatelessWidget {
  const NicesoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      isUseAppbar: true,
      title: 'test',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('niceso screen')
          ],
        ),
      ),
    );
  }
}
