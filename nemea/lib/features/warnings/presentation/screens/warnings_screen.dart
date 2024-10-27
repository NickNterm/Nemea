import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';
import 'package:nemea/features/warnings/presentation/bloc/warnings/warnings_bloc.dart';
import 'package:nemea/features/warnings/presentation/widgets/warning_tile.dart';
import 'package:nemea/main_app.dart';
import 'package:nemea/utils/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WarningsScreen extends StatefulWidget {
  const WarningsScreen({super.key});

  @override
  State<WarningsScreen> createState() => _WarningsScreenState();
}

class _WarningsScreenState extends State<WarningsScreen> {
  @override
  void initState() {
    super.initState();
    if (sl<WarningsBloc>().state is WarningsInitial) {
      sl<WarningsBloc>().add(GetWarnings());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.warnings_title.tr(),
      ),
      body: BlocBuilder<WarningsBloc, WarningsState>(
        bloc: sl<WarningsBloc>(),
        builder: (context, state) {
          List<Warning> warnings = List.generate(10, (index) => Warning.fake());
          if (state is WarningsLoaded) {
            warnings = state.warnings;
          }
          return ScrollbarTheme(
            data: ScrollbarThemeData(
              radius: Radius.circular(8),
              mainAxisMargin: 16,
              interactive: true,
              crossAxisMargin: 4,
              thickness: MaterialStateProperty.all(4),
            ),
            child: Scrollbar(
              child: Skeletonizer(
                enabled: state is WarningsLoading,
                effect: ShimmerEffect(baseColor: Colors.grey[300]!),
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 32,
                    bottom: 50,
                  ),
                  itemCount: warnings.length,
                  itemBuilder: (context, index) {
                    Warning warning = warnings[index];
                    return GestureDetector(
                      onTap: () async {},
                      child: WarningTile(
                        warning: warning,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
