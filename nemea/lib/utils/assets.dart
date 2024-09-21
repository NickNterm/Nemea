import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Assets {
  static AssetIcons icons = AssetIcons();

  static Widget fromSvg({
    required String svgPath,
    Color? color,
    double? width,
    double? height,
    BoxFit? fit,
    BlendMode blendMode = BlendMode.srcIn,
    double padding = 0,
  }) {
    return Container(
      width: width ?? 24,
      height: height ?? 24,
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
          svgPath,
          width: width ?? 24,
          height: height ?? 24,
          alignment: Alignment.center,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(
                  color,
                  blendMode,
                ),
          fit: fit ?? BoxFit.contain,
        ),
      ),
    );
  }
}

class AssetIcons {
  String get rainIcon => 'assets/icons/rain_icon.svg';

  String get backIcon => 'assets/icons/back_icon.svg';

  String get forwardIcon => 'assets/icons/forward_icon.svg';

  String get warningsIcon => 'assets/icons/warnings_icon.svg';

  String get windIcon => 'assets/icons/wind_icon.svg';

  String get windIcon1 => 'assets/icons/wind_icon_1.svg';

  String get windDirection => 'assets/icons/wind_direction.svg';

  String get dropIcon => 'assets/icons/drop_icon.svg';

  String get pressureIcon => 'assets/icons/pressure_icon.svg';

  String get solarRadiationIcon => 'assets/icons/sun_icon.svg';

  String get menuIcon => 'assets/icons/menu_icon.svg';

  String get logoutIcon => 'assets/icons/logout_icon.svg';

  String get peopleAmea => 'assets/icons/people_amea.svg';

  String get peopleDimos => 'assets/icons/people_dimos.svg';

  String get peopleContact => 'assets/icons/people_contact.svg';

  String get assetMap => 'assets/icons/asset_map.svg';

  String get machinery => 'assets/icons/machinery.svg';
}
