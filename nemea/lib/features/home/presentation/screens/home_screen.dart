import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/core/widgets/custom_button.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';
import 'package:nemea/features/home/presentation/bloc/meteo/meteo_bloc.dart';
import 'package:nemea/features/home/presentation/helpers/fire_map_helper.dart';
import 'package:nemea/features/home/presentation/screens/geomap_screen.dart';
import 'package:nemea/features/home/presentation/widgets/meteo_card.dart';
import 'package:nemea/utils/assets.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:nemea/utils/locale_keys.g.dart';
import 'package:nemea/utils/route_generator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    sl<MeteoBloc>().add(GetMeteo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/icons/nemea_app_logo.png', // Add this line
                fit: BoxFit.contain, // Add this line
              ), // Add this line
              decoration: BoxDecoration(
                color: context.palette.primaryColor,
              ),
            ),
            ListTile(
              title: Text(
                LocaleKeys.home_people_list.tr(),
              ),
              onTap: () {
                Navigator.pushNamed(context, PEOPLE_LIST_SCREEN);
              },
            ),
            ListTile(
              title: Text(
                LocaleKeys.warnings_title.tr(),
              ),
              onTap: () {
                Navigator.pushNamed(context, WARNINGS_SCREEN);
              },
            ),
            ListTile(
              title: Text(LocaleKeys.home_firemap_title.tr()),
              onTap: () {
                Navigator.pushNamed(context, FIREMAP_SCREEN);
              },
            ),
          ],
        ),
      ),
      appBar: CustomAppBar(
        leading: Align(
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Assets.fromSvg(
                svgPath: Assets.icons.menuIcon,
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          SizedBox(
            height: 30,
            width: 30,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                Navigator.pushNamed(context, '/warnings');
              },
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Align(
                  child: Assets.fromSvg(
                    svgPath: Assets.icons.warningsIcon,
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
        hasLeading: true,
        title: LocaleKeys.home_title.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 32,
            ),
            BlocBuilder<MeteoBloc, MeteoState>(
              bloc: sl<MeteoBloc>(),
              builder: (context, state) {
                List<Meteo> meteos = [
                  Meteo.empty(),
                  Meteo.empty(),
                ];
                if (state is MeteoLoaded) {
                  meteos = state.meteos;
                }
                return Skeletonizer(
                  enabled: state is MeteoLoading,
                  child: ListView.builder(
                    primary: false,
                    itemCount: meteos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Meteo meteo = meteos[index];
                      return MeteoCard(meteo: meteo);
                    },
                  ),
                );
                //return CircularProgressIndicator.adaptive();
              },
            ),
            //BlocBuilder<FwiBloc, FwiState>(
            //  bloc: sl<FwiBloc>()..add(GetFwi()),
            //  builder: (context, state) {
            //    if (state is FwiLoaded) {
            //      return Text(
            //        state.fwi.toString(),
            //      );
            //    } else {
            //      return CircularProgressIndicator.adaptive();
            //    }
            //  },
            //),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, FIREMAP_SCREEN);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 2,
                                color: context.palette.secondaryColor,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Hero(
                                tag: 'firemap',
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Skeletonizer(
                                    enabled: true,
                                    child: Image.network(
                                      FiremapHelper.imageurl(),
                                    ),
                                  ),
                                  imageUrl: FiremapHelper.imageurl(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.home_see_fire_map.tr(),
                                  style: context.textStyles.body1b,
                                ),
                                //Text(
                                //  "deiktis einsi X",
                                //  style: context.textStyles.body1.copyWith(
                                //    color: Colors.grey[700],
                                //  ),
                                //),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Assets.fromSvg(
                            svgPath: Assets.icons.forwardIcon,
                            color: context.palette.primaryColor,
                            width: 32,
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: FlutterMap(
                        options: MapOptions(
                          interactionOptions: InteractionOptions(
                            flags: InteractiveFlag.none,
                          ),
                          initialCenter: LatLng(37.8209242, 22.6596406),
                          initialZoom: 14.3,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                            // Use the recommended flutter_map_cancellable_tile_provider package to
                            // support the cancellation of loading tiles.
                            //tileProvider: CancellableNetworkTileProvider(),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: CustomButton(
                        height: 64,
                        text: LocaleKeys.home_points_of_meeting.tr(),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          overlayColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(0.1),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GeomapScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 56,
            ),
          ],
        ),
      ),
    );
  }
}
