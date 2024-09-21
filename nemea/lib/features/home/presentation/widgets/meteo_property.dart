import 'package:flutter/material.dart';
import 'package:nemea/utils/assets.dart';
import 'package:nemea/utils/extensions/context.dart';

class MeteoProperty extends StatelessWidget {
  const MeteoProperty({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.fromSvg(
          svgPath: icon,
          color: context.palette.secondaryColor,
        ),
        Container(
          height: 18,
          width: 1.3,
          decoration: BoxDecoration(
            color: context.palette.secondaryColor,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 4,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  title,
                  style: context.textStyles.subtitle1b,
                ),
              ),
              Text(
                subtitle,
                style: context.textStyles.subtitle1.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
