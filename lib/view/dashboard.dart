import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_ordo_mobile/controller/dashboard.dart';
import 'package:test_ordo_mobile/model/product.dart';
import 'package:test_ordo_mobile/utils/theme/theme_color.dart';
import 'package:test_ordo_mobile/utils/theme/theme_text_style.dart';
import 'package:test_ordo_mobile/view/base_view.dart';
import 'package:test_ordo_mobile/view/detail_produk.dart';
import 'package:test_ordo_mobile/view/home.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final _dashboardCt = Get.put(DashboardController());

  Widget _icon(Color color, String icon) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6), color: color),
      child: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
      ),
    );
  }

  Widget _search() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Color(0xffF0F0F0),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_search.svg',
                  width: 20,
                  height: 20,
                  color: ThemeColor.activeIcon,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Cari dengan mengetik barang',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeTextStyle.poppinsRegular.copyWith(
                        color: Color(0xff010101).withOpacity(0.21),
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        _icon(Color(0xff64A1F4), 'assets/images/options.svg'),
        SizedBox(
          width: 8,
        ),
        _icon(Color(0xffDFAE1D), 'assets/images/checkout.svg'),
        SizedBox(
          width: 8,
        ),
        _icon(Color(0xffFF485A), 'assets/images/notifications_none.svg'),
      ],
    ).marginSymmetric(horizontal: 16);
  }

  Widget _imagePageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final selected = index == _dashboardCt.selectedImageTop.value;

        return AnimatedContainer(
          width: selected ? 25 : 35,
          height: 8,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: selected ? Color(0xff64A1F4) : Color(0xff3C7DD9)),
        ).marginOnly(right: index == 2 ? 0 : 8);
      }),
    );
  }

  Widget _imagePageView() {
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      child: PageView(
        controller: _dashboardCt.pageController,
        children: _dashboardCt.listImageTop.map((e) => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            e,
            width: Get.width,
            fit: BoxFit.fill,
            height: Get.height * 0.25,
          ),
        ).marginSymmetric(horizontal: 16)).toList(),
      ),
    );
  }

  Widget _itemProduct(Product product, context) {
    return GestureDetector(
      onTap: () => pushNewScreen(context, screen: DetailProdukScreen(product: product,), withNavBar: true),
      // onTap: () => Get.to(DetailProdukScreen(product: product)),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: product.color),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      product.image[0],
                      width: Get.width,
                      height: Get.height * 0.15,
                      fit: product.isFill ? BoxFit.fill : BoxFit.contain,
                    ).marginSymmetric(vertical: 20),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(6, 2, 8, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1000),
                            topRight: Radius.circular(1000),
                            bottomRight: Radius.circular(1000)),
                        color: Color(0xffDFAE1D)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/star.svg',
                          width: 9,
                          height: 9,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${product.rating} | ${product.review}${product.review > 200 ? '+' : ''} rating',
                          style: ThemeTextStyle.poppinsSemiBold
                              .copyWith(fontSize: 8, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.discount > 0) ...[
                        Text(
                          'Rp ${product.price.toInt()}',
                          style: ThemeTextStyle.poppinsRegular.copyWith(
                              fontSize: 12,
                              color: Color(0xff64A1F4),
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          'Rp ${product.discountPrice.toInt()}',
                          style: ThemeTextStyle.poppinsBold
                              .copyWith(fontSize: 12, color: Color(0xff64A1F4)),
                        ),
                      ] else ...[
                        Text('Rp ${product.price.toInt()}\n',
                            style: ThemeTextStyle.poppinsBold.copyWith(
                              fontSize: 12,
                              color: Color(0xff64A1F4),
                            )),
                      ],
                    ],
                  ),
                ),
                if (product.discount > 0) ...[
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 1, 8, 2),
                    decoration: BoxDecoration(
                        color: Color(0xff3C7DD9),
                        borderRadius: BorderRadius.circular(1000)),
                    child: Text(
                      'Diskon ${product.discount}%',
                      style: ThemeTextStyle.poppinsBold
                          .copyWith(fontSize: 8, color: Colors.white),
                    ),
                  )
                ]
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              product.title,
              style: ThemeTextStyle.poppinsSemiBold
                  .copyWith(color: Colors.black, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Column(
        children: [
          _search().marginSymmetric(vertical: 14),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    _imagePageView(),
                    SizedBox(
                      height: 8,
                    ),
                    _imagePageIndicator(),
                    GridView.count(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: _dashboardCt.listProduct
                          .map((product) => _itemProduct(product, context))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
