import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/features/people_list/presentation/bloc/camera_message/camera_message_bloc.dart';
import 'package:nemea/features/people_list/presentation/screens/camera_picture.dart';
import 'package:nemea/utils/extensions/context.dart';

import '../../../../core/dependency_injection.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Κάμερα"),
      body: BlocBuilder<CameraMessageBloc, CameraMessageState>(
        bloc: sl<CameraMessageBloc>()..add(GetCameraMessages()),
        builder: (context, state) {
          if (state is CameraMessageLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is CameraMessageLoaded)
            return ListView.builder(
              itemCount: state.cameraMessages.length,
              itemBuilder: (context, index) {
                final camera = state.cameraMessages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraPictureScreen(
                                imageurl: camera.image_url)));
                  },
                  child: Container(
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
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            camera.image_url,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              camera.message,
                              style: context.textStyles.body1b,
                            ),
                            Text(
                              DateFormat("d/M/y HH:mm")
                                  .format(camera.timestamp),
                              style: context.textStyles.body1,
                            ),
                            Text(
                              camera.severity,
                              style: context.textStyles.body1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          else if (state is CameraMessageError)
            return Center(child: Text("error"));
          else if (state is CameraMessageInitial) return Container();
          return Container();
        },
      ),
    );
  }
}
