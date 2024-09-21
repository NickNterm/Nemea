import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/domain/entities/vardia.dart';
import 'package:nemea/features/people_list/presentation/bloc/vardies/vardies_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/dependency_injection.dart';

class VardiesScreen extends StatefulWidget {
  const VardiesScreen({super.key});

  @override
  State<VardiesScreen> createState() => _VardiesScreenState();
}

class _VardiesScreenState extends State<VardiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Βάρδιες',
      ),
      body: BlocBuilder<VardiesBloc, VardiesState>(
        bloc: sl<VardiesBloc>(),
        builder: (context, state) {
          if (state is VardiesLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is VardiesError)
            return Center(child: Text('Error'));
          else if (state is VardiesLoaded) {
            List<Vardia> vardies = state.vardies;
            return VardiesLayout(vardies: vardies);
          }
          return Container();
        },
      ),
    );
  }
}

class VardiesLayout extends StatefulWidget {
  const VardiesLayout({
    super.key,
    required this.vardies,
  });

  final List<Vardia> vardies;

  @override
  State<VardiesLayout> createState() => _VardiesLayoutState();
}

class _VardiesLayoutState extends State<VardiesLayout> {
  List<Vardia> vardies = [];
  List<Vardia> selectedVardies = [];

  @override
  void initState() {
    super.initState();
    vardies = widget.vardies;
    selectedVardies = vardies
        .where((element) => isSameDay(element.date, DateTime.now()))
        .toList();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: selectedDate,
          firstDay: DateTime.utc(2021, 1, 1),
          lastDay: DateTime.utc(2050, 12, 31),
          selectedDayPredicate: (day) {
            return isSameDay(selectedDate, day);
          },
          eventLoader: (day) {
            return vardies
                .where((element) => isSameDay(element.date, day))
                .toList();
          },
          locale: 'el_GR',
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDate = selected;
              selectedVardies = vardies
                  .where((element) => isSameDay(element.date, selectedDate))
                  .toList();
            });
          },
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          itemCount: selectedVardies.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                title: Text('${selectedVardies[index].type}'),
                subtitle: Text(
                  '${selectedVardies[index].startTime.format(context)} - ${selectedVardies[index].endTime.format(context)}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
