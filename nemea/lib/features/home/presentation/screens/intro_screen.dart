import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nemea/core/widgets/custom_button.dart';
import 'package:nemea/utils/locale_keys.g.dart';
import 'package:nemea/utils/route_generator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 30,
              left: 40,
              right: 40,
              child: CustomButton(
                text: LocaleKeys.intro_start_button.tr(),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HOME_SCREEN);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
