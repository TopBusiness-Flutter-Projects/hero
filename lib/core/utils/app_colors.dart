import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color primary = HexColor('#FEC200');
  static Color primaryOpacity = HexColor('#FEC200').withOpacity(.3);
  static Color primaryOpacity2 =Color.fromRGBO(254, 194, 0, 0.3) ;

  static Color secondPrimary = HexColor('#F4E07D');
  static Color orangeThirdPrimary = HexColor('#FF9201');
  static Color blueLiteColor = HexColor('#00B3DC');
  static Color blueTextColor = HexColor('#5663FF');
  static Color grayTextColor = HexColor('#6E7FAA');
  static Color goldStarColor = HexColor('#FFCC00');
  static Color unStarColor = HexColor('#E9E9EE');
  static Color scaffoldColor = HexColor('#F5F5F5');
  static Color avatarColor = HexColor('#96B2B5');
  static Color numberColor = HexColor('#555555');
  static Color black1 = HexColor('#110101');
  static Color black2 = HexColor('#605F5F');
  static Color black3 = HexColor('#373737');
  static Color black4 = HexColor('#404040');
  static Color grey1 = HexColor('#D9D9D9');
  static Color grey2 = HexColor('#939393');
  static Color grey3 = HexColor('#605F5F');
  static Color grey4 = HexColor('#263238');
  static Color currencyColor = HexColor('#777777');

  static Color green1 = HexColor('#3AAF3C');
  static Color greenLight = HexColor('#A9FEAB');

  static Color hint = Colors.grey;
  static Color blackLite = Colors.black54;
  static Color error = Colors.red;
  static Color success = Colors.green;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color gray = Colors.grey;
  static Color grayLite = Colors.grey[700]!;
  static Color gray1 = HexColor('#C4C4C4');
  static Color gray2 = HexColor('#BABABB');
  static Color gray3 = HexColor('#424242');
  static Color gray4 = HexColor('#767676');
  static Color gray5 = HexColor('#37474F');
  static Color dateColor = HexColor('#666565');
  static Color weekColor = HexColor('#F7F3F3');
  static Color weekNumberColor = HexColor('#009541');
  static Color buttonColor = HexColor('#4C4C6D');

  static Color gray6 = HexColor('#A7A7A7');
  // static Color gray7 = HexColor('#A0A1A0');
  static Color red = HexColor('#FF0000');
  static Color totalProfitsColor = HexColor('#009541');
  static Color blue3 = Color(0xff3646ff);
  static Color bink = HexColor('#FF9F9F');
  static Color purple1 = HexColor('#854AA4');
  static Color purple1light = HexColor('#E3D2FE');
  static Color blue = HexColor('#143A7B');
  static Color blue1 = HexColor('#CBDFF8');
  static Color blue2 = HexColor('#8290F8');
  static Color blue4 = Color(0xff3E3F68);
  static Color bluelight = HexColor('#D7EAF9');
  static Color orange = HexColor('#FE7C04');
  static Color orangelight = HexColor('#FFEAD7');
  static Color opacityWhite = Colors.white.withOpacity(0.5);
  static Color transparent = Colors.transparent;


  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight = hsl.withLightness(
        (hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}