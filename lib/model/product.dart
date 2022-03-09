import 'package:flutter/material.dart';

class Product {
  final List<String> image;
  final String title;
  final double price;
  final double discountPrice;
  final int discount;
  final int id;
  final double rating;
  final int review;
  final Color color;
  final bool isNew;
  final int stok;
  final int sold;
  final bool isFill;

  Product(this.image, this.title, this.price, this.discountPrice, this.discount, this.id,
      this.rating, this.review, this.color, this.isNew, this.stok, this.sold, this.isFill);
}