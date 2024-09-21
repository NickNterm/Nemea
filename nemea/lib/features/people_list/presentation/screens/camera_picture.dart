import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/features/home/presentation/helpers/fire_map_helper.dart';
import 'package:nemea/utils/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CameraPictureScreen extends StatelessWidget {
  const CameraPictureScreen({
    super.key,
    required this.imageurl,
  });

  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            placeholder: (context, url) => Skeletonizer(
              child: Image.network(
                imageurl,
              ),
            ),
            imageUrl: imageurl,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
