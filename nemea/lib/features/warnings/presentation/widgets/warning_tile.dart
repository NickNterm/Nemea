import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';
import 'package:nemea/utils/extensions/context.dart';

class WarningTile extends StatelessWidget {
  const WarningTile({
    super.key,
    required this.warning,
  });

  final Warning warning;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  warning.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.header2.copyWith(),
                ),
              ),
              Text(
                DateFormat.yMEd().format(warning.datetime).toString(),
                style: context.textStyles.body2b.copyWith(color: Colors.grey),
              ),
            ],
          ),
          warning.description != null
              ? Container(
                  margin: const EdgeInsets.only(
                    top: 1,
                    bottom: 8,
                  ),
                  height: 1.3,
                  constraints: BoxConstraints(
                    maxWidth: 75,
                  ),
                  decoration: BoxDecoration(
                    color: context.palette.secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Opacity(
                    opacity: 0.0,
                    child: Text(
                      warning.title,
                      style: context.textStyles.header3,
                    ),
                  ),
                )
              : Container(),
          warning.description != null
              ? Text(
                  warning.description ?? '',
                  style: context.textStyles.body1,
                )
              : Container(),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            height: 0.5,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
        ],
      ),
    );
  }
}
