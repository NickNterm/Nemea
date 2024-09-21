import 'package:flutter/material.dart';
import 'package:nemea/utils/assets.dart';
import 'package:nemea/utils/extensions/context.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 64,
    this.hasLeading = true,
    this.leading,
    this.padding = 16,
    this.leadingOnPressed,
    this.actions = const [],
  });

  final String title;
  final double height;
  final bool hasLeading;
  final Widget? leading;
  final double padding;
  final VoidCallback? leadingOnPressed;
  final List<Widget> actions;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      title: Text(
        title,
        style: context.textStyles.header2.copyWith(
          color: context.palette.compTextColor,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: context.palette.primaryColor,
      leading: hasLeading
          ? leading == null
              ? Padding(
                  padding: EdgeInsets.only(left: padding),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: leadingOnPressed ??
                            () => Navigator.of(context).pop(),
                        child: Assets.fromSvg(
                          svgPath: Assets.icons.backIcon,
                          color: context.palette.compTextColor,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                )
              : leading!
          : SizedBox(),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions,
            ],
          ),
        )
      ],
    );
  }
}
