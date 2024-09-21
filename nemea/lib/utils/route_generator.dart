import 'package:flutter/material.dart';
import 'package:nemea/features/home/presentation/screens/fire_map_screen.dart';
import 'package:nemea/features/home/presentation/screens/home_screen.dart';
import 'package:nemea/features/people_list/presentation/people_list_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/amea_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/camera_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/machine_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/manager_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/vardies_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/volunteer_screen.dart';
import 'package:nemea/features/warnings/presentation/screens/warnings_screen.dart';

import '../core/pages/application.dart';

const String FIRST_SCREEN = '/';
const String HOME_SCREEN = '/home';
const String WARNINGS_SCREEN = '/warnings';
const String FIREMAP_SCREEN = '/firemap';
const String PEOPLE_LIST_SCREEN = '/people_list';
const String VOLUNTEER_LIST_SCREEN = '/volunteer_list';
const String MACHINE_LIST_SCREEN = '/machine_list';
const String AMEA_LIST_SCREEN = '/amea_list';
const String MANAGER_LIST_SCREEN = '/manager_list';
const String CAMERA_SCREEN = '/camera';
const String VARDIES_SCREEN = '/vardies';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case FIRST_SCREEN:
        return MaterialPageRoute(
          builder: (context) => Application(),
        );

      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );

      case WARNINGS_SCREEN:
        return MaterialPageRoute(
          builder: (context) => WarningsScreen(),
        );

      case FIREMAP_SCREEN:
        return MaterialPageRoute(
          builder: (context) => FiremapScreen(),
        );

      case PEOPLE_LIST_SCREEN:
        return MaterialPageRoute(
          builder: (context) => PeopleListScreen(),
        );

      case AMEA_LIST_SCREEN:
        return MaterialPageRoute(
          builder: (context) => AmeaScreen(),
        );

      case VOLUNTEER_LIST_SCREEN:
        return MaterialPageRoute(
          builder: (context) => VolunteerScreen(),
        );

      case MANAGER_LIST_SCREEN:
        return MaterialPageRoute(
          builder: (context) => ManagerScreen(),
        );

      case MACHINE_LIST_SCREEN:
        return MaterialPageRoute(
          builder: (context) => MachineScreen(),
        );

      case CAMERA_SCREEN:
        return MaterialPageRoute(
          builder: (context) => CameraScreen(),
        );

      case VARDIES_SCREEN:
        return MaterialPageRoute(
          builder: (context) => VardiesScreen(),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _error();
    }
  }

  static Route<dynamic> _error() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
