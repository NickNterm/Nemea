import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/presentation/screens/geomap_screen.dart';
import 'package:nemea/features/people_list/presentation/bloc/user/user_bloc.dart';
import 'package:nemea/features/people_list/presentation/screens/geomap_many_screen.dart';
import 'package:nemea/utils/assets.dart';
import 'package:nemea/utils/locale_keys.g.dart';
import 'package:nemea/utils/route_generator.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({
    super.key,
  });

  @override
  // TODO: components giati den exw xrono
  Widget build(BuildContext context) {
    double containerDim = 150;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.home_people_list.tr(),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    LocaleKeys.people_list_logout_title.tr(),
                  ),
                  content: Text(
                    LocaleKeys.people_list_logout_message.tr(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        LocaleKeys.people_list_logout_cancel.tr(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        sl<UserBloc>().add(
                          UserLogoutEvent(),
                        );
                      },
                      child: Text(
                        LocaleKeys.people_list_logout_yes_logout.tr(),
                      ),
                    ),
                  ],
                ),
              );
              //sl<UserBloc>().add(UserLogoutEvent());
            },
            child: Assets.fromSvg(
              svgPath: Assets.icons.logoutIcon,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, MACHINE_LIST_SCREEN);
                  },
                  child: Container(
                      height: containerDim,
                      width: containerDim,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/icons/machinery.png',
                            height: 100,
                            width: 100,
                          ),
                          Text("Επιχειρησιακά Μέσα")
                        ],
                      )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, MANAGER_LIST_SCREEN);
                  },
                  child: Container(
                    height: containerDim,
                    width: containerDim,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/icons/people_contact.png',
                          height: 100,
                          width: 100,
                        ),
                        Text("Υπεύθυνοι Δήμου")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, VOLUNTEER_LIST_SCREEN);
                  },
                  child: Container(
                    height: containerDim,
                    width: containerDim,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/icons/people_dimos.png',
                          height: 100,
                          width: 100,
                        ),
                        Text("Κατάλογος\nεθελοντών")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, AMEA_LIST_SCREEN);
                  },
                  child: Container(
                    height: containerDim,
                    width: containerDim,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/icons/people_amea.png',
                          height: 100,
                          width: 100,
                        ),
                        Text("Κατάλογος ΑΜΕΑ")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeomapManyScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: containerDim,
                    width: containerDim,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/icons/asset_map.png',
                          height: 100,
                          width: 100,
                        ),
                        Text("Χάρτης Υποδομών")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, CAMERA_SCREEN);
                  },
                  child: Container(
                    height: containerDim,
                    width: containerDim,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/camera.jpg',
                          height: 100,
                          width: 100,
                        ),
                        Text("Κάμερα")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
