import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:test_ordo_mobile/controller/dashboard.dart';
import 'package:test_ordo_mobile/controller/detail_produk.dart';
import 'package:test_ordo_mobile/model/product.dart';
import 'package:test_ordo_mobile/utils/theme/theme_text_style.dart';
import 'package:test_ordo_mobile/view/checkout.dart';

class DetailProdukScreen extends StatefulWidget {
  final Product product;

  DetailProdukScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  final DashboardController _dashboardCt = Get.find();

  final _detailProdukCt = Get.put(DetailProdukController());

  Widget _imagePageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final selected = index == _detailProdukCt.selectedImageTop.value;

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
        controller: _detailProdukCt.pageController,
        children: widget.product.image.map((e) => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            e,
            width: Get.width,
            fit: BoxFit.contain,
            height: Get.height * 0.25,
          ),
        ).marginSymmetric(horizontal: 16)).toList(),
      ),
    );
  }

  Widget get _appbar {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset('assets/images/back_button.svg', height: 24, width: 24,),
        ),
        SizedBox(width: 16,),
        Expanded(
          child: Text('PRODUK DETAIL', style: ThemeTextStyle.poppinsBold.copyWith(fontSize: 14, color: Color(0xff64A1F4)),),
        ),
        GestureDetector(
          onTap: () => pushNewScreen(context, screen: CheckoutScreen(), withNavBar: true),
          child: SvgPicture.asset('assets/images/checkout.svg', color: Color(0xff64A1F4), width: 24, height: 24,),
        ),
        SizedBox(width: 8,),
        SvgPicture.asset('assets/images/notifications_none.svg', color: Color(0xffFF485A), width: 24, height: 24,),
      ],
    );
  }

  Widget _containerText(String title, double textSize, Color color) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 1, 6, 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: color
      ),
      child: Text(title, style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.white, fontSize: textSize),),
    );
  }

  Widget get _content {
    return Stack(
      children: [
        Container(
          width: Get.width, height: Get.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
            color: Color(0xffFF485A)
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: Text(widget.product.title, style: ThemeTextStyle.poppinsBold.copyWith(color: Color(0xff47623F), fontSize: 16),),
                  ),
                  SizedBox(width: 10,),
                  if (!widget.product.isNew) ...[
                    _containerText('Barang Bekas', 10, Color(0xffDFAE1D))
                  ],
                  SizedBox(width: 8,),
                  _containerText('${widget.product.stok}', 10, Color(0xff64A1F4))
                ],
              ),
              SizedBox(height: 6,),
              if (widget.product.discount > 0) ...[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp ${widget.product.price.toInt()}',
                            style: ThemeTextStyle.poppinsRegular.copyWith(
                                fontSize: 12,
                                color: Color(0xff64A1F4),
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            'Rp ${widget.product.discountPrice.toInt()}',
                            style: ThemeTextStyle.poppinsBold
                                .copyWith(fontSize: 12, color: Color(0xff64A1F4)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    _containerText('Diskon ${widget.product.discount}%', 10, Color(0xff3C7DD9))
                  ],
                ),
              ] else ...[
                Text('Rp ${widget.product.price.toInt()}\n',
                    style: ThemeTextStyle.poppinsBold.copyWith(
                      fontSize: 12,
                      color: Color(0xff64A1F4),
                    )),
              ],
              SizedBox(height: 14,),
              Divider(color: Colors.black12, height: 1,),
              SizedBox(height: 14,),
              Text('Vendor', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Color(0xff47623F), fontSize: 14),),
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset('assets/images/eiger.png', width: 28, height: 28,),
                        ),
                        SizedBox(width: 8,),
                        Expanded(child: Text('Eiger Store', style: ThemeTextStyle.poppinsBold.copyWith(color: Colors.black, fontSize: 14),))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images/star.svg', width: 10, height: 10, color: Color(0xff64A1F4),),
                        SizedBox(width: 4,),
                        Flexible(child: Text('${widget.product.rating} | ${widget.product.sold} Terjual', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Color(0xff64A1F4), fontSize: 10),))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Text('Deskripsi', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Color(0xff47623F), fontSize: 14),),
              SizedBox(height: 2,),
              Text('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.', style: ThemeTextStyle.poppinsRegular.copyWith(color: Color(0xff47623F), fontSize: 12),),
              SizedBox(height: 8,),
              Text('Ulasan dan Penilaian', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Color(0xff47623F), fontSize: 14),),
              SizedBox(height: 16,),
              Column(
                children: _detailProdukCt.listPenilaian.map((e) => Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), offset: Offset(0, 2), blurRadius: 10, spreadRadius: 0
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(e['image'], width: 20, height: 20,),
                          SizedBox(width: 8,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e['author'], style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 14),),
                                Text(e['time'], style: ThemeTextStyle.poppinsRegular.copyWith(color: Color(0xffB4BBC6), fontSize: 11),),
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/images/star.svg', width: 16, height: 16, color: Color(0xffFA4A0C),),
                          SizedBox(width: 4,),
                          Text(e['rating'], style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 16),)
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text(e['comment'], style: ThemeTextStyle.poppinsRegular.copyWith(color: Color(0xff272727), fontSize: 12),)
                    ],
                  ),
                )).toList(),
              ),
              SizedBox(height: 16,)
            ],
          ).paddingSymmetric(horizontal: 20),
        ).marginOnly(top: 12),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    Get.delete<DetailProdukController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
          children: [
            _appbar.paddingSymmetric(horizontal: 16).marginSymmetric(vertical: 14),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _imagePageView(),
                    SizedBox(height: 8,),
                    _imagePageIndicator(),
                    SizedBox(height: 16,),
                    _content
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
