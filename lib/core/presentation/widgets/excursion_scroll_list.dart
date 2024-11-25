import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class ExcursionScrollList extends StatefulWidget {
  const ExcursionScrollList({
    super.key,
    required this.tourList,
    required this.title,
    this.onTapAction,
  });

  final List<IExcursion> tourList;
  final String title;
  final Function(IExcursion)? onTapAction;

  @override
  State<ExcursionScrollList> createState() => _ExcursionScrollListState();
}

class _ExcursionScrollListState extends State<ExcursionScrollList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            widget.title,
            style: AppTextTheme.semiBold18,
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 15,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.tourList.length,
            separatorBuilder: (BuildContext context, _) => const SizedBox(
              width: 10,
            ),
            itemBuilder: (context, i) {
              final tour = widget.tourList[i];
              return ExcursionScrollElement(
                excursion: tour,
                onTapAction: widget.onTapAction,
              );
            },
          ),
        ),
      ],
    );
  }
}
