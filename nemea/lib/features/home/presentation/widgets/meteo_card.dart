import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';
import 'package:nemea/features/home/presentation/widgets/meteo_property.dart';
import 'package:nemea/utils/assets.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:nemea/utils/locale_keys.g.dart';

class MeteoCard extends StatelessWidget {
  const MeteoCard({
    super.key,
    required this.meteo,
  });

  final Meteo meteo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.palette.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12,
              left: 12,
              bottom: 12,
              top: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meteo.name,
                        style: context.textStyles.header1.copyWith(
                          fontSize: 18,
                          color: context.palette.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: GoogleFonts.ubuntu().fontFamily,
                        ),
                      ),
                      Text(
                        "${meteo.temp}°C",
                        style: context.textStyles.header1.copyWith(
                          height: 1,
                          fontFamily: GoogleFonts.ubuntu().fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 27,
                          color: context.palette.secondaryColor,
                        ),
                      ),
                      Text(
                        DateFormat("hh:mm dd/MM/yy").format(meteo.date),
                        style: context.textStyles.subtitle1.copyWith(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      MeteoProperty(
                        icon: Assets.icons.solarRadiationIcon,
                        title: LocaleKeys.home_meteo_solar_radiation.tr(),
                        subtitle: meteo.solarRadiation.toString(),
                      ),
                      MeteoProperty(
                        icon: Assets.icons.dropIcon,
                        title: LocaleKeys.home_meteo_rh.tr(),
                        subtitle: meteo.rh.toString(),
                      ),
                      MeteoProperty(
                        icon: Assets.icons.pressureIcon,
                        title: LocaleKeys.home_meteo_pressure.tr(),
                        subtitle: meteo.pressure.toString(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MeteoProperty(
                        icon: Assets.icons.rainIcon,
                        title: LocaleKeys.home_meteo_rain.tr(),
                        subtitle: meteo.rain.toString(),
                      ),
                      MeteoProperty(
                        icon: Assets.icons.windIcon1,
                        title: LocaleKeys.home_meteo_wind_speed.tr(),
                        subtitle: meteo.windSpeed.toString(),
                      ),
                      MeteoProperty(
                        icon: Assets.icons.windDirection,
                        title: LocaleKeys.home_meteo_wind_direction.tr(),
                        subtitle: meteo.windDirection.toString(),
                      ),
                      MeteoProperty(
                        icon: Assets.icons.windIcon,
                        title: LocaleKeys.home_meteo_wind_gust.tr(),
                        subtitle: meteo.windGust.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
