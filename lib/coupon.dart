import 'package:flutter/material.dart';

class Coupon {
  final String title;
  final String url;

  Coupon({@required this.title, @required this.url});

  bool isSvg() => title.split(".")[1] == 'svg';
}
