import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/presentation/bloc/machine/machine_bloc.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:url_launcher/url_launcher.dart';

class MachineScreen extends StatefulWidget {
  const MachineScreen({super.key});

  @override
  State<MachineScreen> createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  @override
  void initState() {
    super.initState();
    sl<MachineBloc>().add(GetMachine());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Μηχανήματα"),
      body: BlocBuilder<MachineBloc, MachineState>(
        bloc: sl<MachineBloc>(),
        builder: (context, state) {
          if (state is MachineLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is MachineLoaded)
            return ListView.builder(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 50,
              ),
              itemCount: state.machines.length,
              itemBuilder: (context, index) {
                final machine = state.machines[index];
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
                        machine.function,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        machine.registrationNumber,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        machine.operatorName,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        machine.owner,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        machine.agency,
                        style: context.textStyles.body1,
                      ),
                      Text(
                        machine.area,
                        style: context.textStyles.body1,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () async {
                            !await launchUrl(
                              Uri.parse("tel:${machine.cellPhoneNumber}"),
                            );
                          },
                          child: Text(
                            machine.cellPhoneNumber,
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
          else if (state is MachineError)
            return Center(child: Text("error"));
          else if (state is MachineInitial) return Container();
          return Container();
        },
      ),
    );
  }
}
