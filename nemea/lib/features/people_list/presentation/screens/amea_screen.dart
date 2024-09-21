import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/presentation/bloc/amea/amea_bloc.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:nemea/utils/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class AmeaScreen extends StatefulWidget {
  const AmeaScreen({super.key});

  @override
  State<AmeaScreen> createState() => _AmeaScreenState();
}

class _AmeaScreenState extends State<AmeaScreen> {
  @override
  void initState() {
    super.initState();
    sl<AmeaBloc>().add(GetAmea());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ΑΜΕΑ"),
      body: BlocBuilder<AmeaBloc, AmeaState>(
        bloc: sl<AmeaBloc>(),
        builder: (context, state) {
          if (state is AmeaLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is AmeaLoaded)
            return ListView.builder(
              itemCount: state.ameas.length,
              itemBuilder: (context, index) {
                final amea = state.ameas[index];
                return Container(
                  margin: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${amea.name} ${amea.surname}",
                        style: context.textStyles.body1b,
                      ),
                      Text(
                        amea.residence,
                        style: context.textStyles.body1,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () async {
                            !await launchUrl(
                              Uri.parse("tel:${amea.cellPhoneNumber}"),
                            );
                          },
                          child: Text(
                            amea.cellPhoneNumber,
                            style: context.textStyles.body1.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () async {
                            !await launchUrl(
                              Uri.parse("tel:${amea.residencePhoneNumber}"),
                            );
                          },
                          child: Text(
                            amea.residencePhoneNumber,
                            style: context.textStyles.body1.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          else if (state is AmeaError)
            return Center(child: Text("error"));
          else if (state is AmeaInitial) return Container();
          return Container();
        },
      ),
    );
  }
}
