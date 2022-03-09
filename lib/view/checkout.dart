import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test_ordo_mobile/controller/checkout.dart';
import 'package:test_ordo_mobile/utils/theme/theme_text_style.dart';
import 'package:test_ordo_mobile/view/base_view.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final _checkoutCt = Get.put(CheckoutController());

  Widget get _appbar {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset('assets/images/back_button.svg', height: 24, width: 24,),
        ),
        SizedBox(width: 16,),
        Expanded(
          child: Text('Checkout', style: ThemeTextStyle.poppinsBold.copyWith(fontSize: 14, color: Color(0xff64A1F4)),),
        ),
      ],
    );
  }

  Widget _itemCheckout(Map product, int index) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(product['id']),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          width: 30, height: 30,
          decoration: BoxDecoration(
            color: Color(0xff64A1F4),
            borderRadius: BorderRadius.circular(1000)
          ),
          child: SvgPicture.asset('assets/images/delete_button.svg', width: 15, height: 15,),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: Image.asset(product['image'], width: 35, height: 35, fit: BoxFit.contain,),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['title'], style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 14),),
                      SizedBox(height: 4,),
                      Text('Rp ${product['price']}', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Color(0xff64A1F4), fontSize: 12),),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: Color(0xff3C7DD9),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (product['buy'] == 1) return;

                              product['buy'] = product['buy'] - 1;
                              _checkoutCt.listCheckout[index] = product;
                            },
                            child: Text('-', style: ThemeTextStyle.poppinsBold.copyWith(color: Colors.white, fontSize: 14),),
                          ),
                          SizedBox(width: 4,),
                          Text('${product['buy']}', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.white, fontSize: 12),),
                          SizedBox(width: 4,),
                          GestureDetector(
                            onTap: () {
                              product['buy'] = product['buy'] + 1;
                              _checkoutCt.listCheckout[index] = product;
                            },
                            child: Text('+', style: ThemeTextStyle.poppinsBold.copyWith(color: Colors.white, fontSize: 14),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4,),
                    GestureDetector(
                      onTap: () {
                        product['catatan'] = product['catatan'] == null ? '' : null;

                        _checkoutCt.listCheckout[index] = product;
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 1, 6, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Color(0xff64A1F4),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(product['catatan'] == null ? 'assets/images/create.svg' : 'assets/images/delete_sweep.svg', width: 12, height: 12, color: Colors.white,),
                            SizedBox(width: 4,),
                            Text(product['catatan'] == null ? 'Catatan' : 'Hapus Catatan', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          if (product['catatan'] != null) ...[
            Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Catatan Item', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 12),),
                  SizedBox(height: 4,),
                  TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    style: ThemeTextStyle.poppinsRegular.copyWith(color: Colors.black, fontSize: 12),
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        hintText: 'Ketik disini...',
                        hintStyle: ThemeTextStyle.poppinsRegular.copyWith(color: Color(0xffcdcdcd), fontSize: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.black26)
                        )
                    ),
                  )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  int get _total {
    var price = 0;
    _checkoutCt.listCheckout.forEach((element) {
      price += int.parse('${element['price']}') * int.parse('${element['buy']}');
    });
    price += 10000;
    return price;
  }

  @override
  void dispose() {
    Get.delete<CheckoutController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appbar.paddingSymmetric(horizontal: 16).marginSymmetric(vertical: 14),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _checkoutCt.listCheckout.length,
                      itemBuilder: (_, index) => _itemCheckout(_checkoutCt.listCheckout[index], index),
                      separatorBuilder: (BuildContext context, int index) => Divider(height: 16, color: Colors.transparent,),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Catatan Pesanan', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 12),),
                          SizedBox(height: 4,),
                          TextFormField(
                            minLines: 3,
                            maxLines: 5,
                            style: ThemeTextStyle.poppinsRegular.copyWith(color: Colors.black, fontSize: 12),
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                hintText: 'Ketik disini...',
                                hintStyle: ThemeTextStyle.poppinsRegular.copyWith(color: Color(0xffcdcdcd), fontSize: 12),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.black26)
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('Detail Pembayaran', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 14),),
                    SizedBox(height: 16,),
                    Column(
                      children: _checkoutCt.listCheckout.map((product) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['title'], style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 14),),
                          Row(
                            children: [
                              Expanded(
                                child: Text('(Qty.${product['buy']})', style: ThemeTextStyle.poppinsRegular.copyWith(color: Colors.black, fontSize: 12),),
                              ),
                              Text('Rp ${product['price'] * product['buy']}', style: ThemeTextStyle.poppinsRegular.copyWith(color: Colors.black, fontSize: 12),),
                            ],
                          )
                        ],
                      ).marginOnly(bottom: 8)).toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Ongkos Kirim', style: ThemeTextStyle.poppinsRegular.copyWith(color: Colors.black, fontSize: 12),),
                        ),
                        Text('Rp 10.000', style: ThemeTextStyle.poppinsRegular.copyWith(color: Colors.black, fontSize: 12),),
                      ],
                    ),
                    SizedBox(height: 4,),
                    Divider(color: Colors.black26,),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Sub Total', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 12),),
                        ),
                        Text('Rp $_total', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.black, fontSize: 12),),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 5, 12, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: Color(0xff3C7DD9)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Waktu Pengantaran', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.white, fontSize: 12),),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.chevron_right, color: Colors.white, size: 16,)
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 5, 12, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Color(0xff3C7DD9)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Alamat Pengiriman', style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.white, fontSize: 12),),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.chevron_right, color: Colors.white, size: 16,)
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), offset: Offset(0, 2), blurRadius: 10, spreadRadius: 0
                          )
                        ]
                      ),
                      child: Text('Tolong pastikan semua pesanan anda sudah benar dan tidak kurang.', textAlign: TextAlign.center, style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Color(0xff47623F), fontSize: 11),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(24, 7, 24, 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Color(0xff3C7DD9)
                          ),
                          child: Row(
                            children: [
                              Text('Bayar Sekarang', textAlign: TextAlign.center, style: ThemeTextStyle.poppinsSemiBold.copyWith(color: Colors.white, fontSize: 12),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28,)
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
