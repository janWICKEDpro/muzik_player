import 'package:flutter/material.dart';
import 'package:muzik_player/themes/colors.dart';

class MuzikPlayerTextTheme {
  static const tabBarStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w400);
  static const songNameStyle = TextStyle(
      color: AppColors.primaryWhitishGrey,
      fontFamily: 'Poppins',
      fontSize: 15,
      fontWeight: FontWeight.w900);
  static final authorNameStyle = TextStyle(
      color: AppColors.primaryWhitishGrey.withOpacity(0.6),
      fontFamily: 'Poppins',
      fontSize: 12,
      fontWeight: FontWeight.w400);
}
