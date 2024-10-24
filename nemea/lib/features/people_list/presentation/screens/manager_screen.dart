import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/presentation/bloc/manager/manager_bloc.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  @override
  void initState() {
    super.initState();
    sl<ManagerBloc>().add(GetManager());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Υπέυθυνοι Δήμου"),
      body: BlocBuilder<ManagerBloc, ManagerState>(
        bloc: sl<ManagerBloc>(),
        builder: (context, state) {
          if (state is ManagerLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is ManagerLoaded)
            return ListView.builder(
              itemCount: state.managers.length,
              itemBuilder: (context, index) {
                final manager = state.managers[index];
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
                        "${manager.name} ${manager.surname}",
                        style: context.textStyles.body1b,
                      ),
                      Text(
                        manager.jobTitle,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        manager.jobAttribute,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        manager.specialization,
                        style: context.textStyles.body1,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () async {
                            !await launchUrl(
                              Uri.parse("tel:${manager.cellPhoneNumber}"),
                            );
                          },
                          child: Text(
                            manager.cellPhoneNumber,
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
          else if (state is ManagerError)
            return Center(child: Text("error"));
          else if (state is ManagerInitial) return Container();
          return Container();
        },
      ),
    );
  }
}
