import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class TourDescription extends StatefulWidget {
  const TourDescription({super.key, required this.desc});

  final String desc;

  @override
  State<TourDescription> createState() => _TourDescriptionState(desc, false);
}

class _TourDescriptionState extends State<TourDescription> {
  final String desc;
  bool isOpenText;

  _TourDescriptionState(this.desc, this.isOpenText);

  void _tapReadMore() => isOpenText = !isOpenText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'О событии',
          textAlign: TextAlign.left,
          style: AppTextTheme.semiBold18,
        ),
        Text(
          desc,
          textAlign: TextAlign.left,
          style: AppTextTheme.normal14.copyWith(
            color: AppColors.lightGray,
          ),
          softWrap: true,
          maxLines: isOpenText ? null : 4,
          overflow: isOpenText ? null : TextOverflow.ellipsis,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          ),
          onPressed: () {
            setState(_tapReadMore);
          },
          child: Text(
            isOpenText ? 'Свернуть' : 'Развернуть',
            textAlign: TextAlign.left,
            style: AppTextTheme.medium15,
          ),
        ),
      ],
    );
  }
}
