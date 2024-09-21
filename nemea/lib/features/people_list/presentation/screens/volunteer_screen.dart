import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/presentation/bloc/volunteer/volunteer_bloc.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/route_generator.dart';
import '../bloc/vardies/vardies_bloc.dart';

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({super.key});

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  @override
  void initState() {
    super.initState();
    sl<VolunteerBloc>().add(GetVolunteer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Εθελοντές",
        actions: [
          GestureDetector(
            onTap: () {
              sl<VardiesBloc>().add(GetVardies());
              Navigator.pushNamed(context, VARDIES_SCREEN);
            },
            child: Text(
              "Βάρδιες",
              style: context.textStyles.body1b.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<VolunteerBloc, VolunteerState>(
        bloc: sl<VolunteerBloc>(),
        builder: (context, state) {
          if (state is VolunteerLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is VolunteerLoaded)
            return ListView.builder(
              itemCount: state.volunteer.length,
              itemBuilder: (context, index) {
                final volunteer = state.volunteer[index];
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
                        "${volunteer.name} ${volunteer.surname}",
                        style: context.textStyles.body1b,
                      ),
                      Text(
                        volunteer.location,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        volunteer.team,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        volunteer.specialization,
                        style: context.textStyles.body1,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () async {
                            !await launchUrl(
                              Uri.parse("tel:${volunteer.phone}"),
                            );
                          },
                          child: Text(
                            volunteer.phone,
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
                              Uri.parse("mailto:${volunteer.mail}"),
                            );
                          },
                          child: Text(
                            volunteer.mail,
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
          else if (state is VolunteerError)
            return Center(child: Text("error"));
          else if (state is VolunteerInitial) return Container();
          return Container();
        },
      ),
    );
  }
}
