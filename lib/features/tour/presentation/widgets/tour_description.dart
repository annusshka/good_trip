import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/theme.dart';

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
        Text('О событии',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        isOpenText
            ? Text(desc,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colors.darkGray),
                softWrap: true,
              )
            : Text(
              desc,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colors.darkGray),
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.zero),
          ),
            onPressed: () {
              setState(() {
                _tapReadMore();
              });
            },
            child: Text(isOpenText ? 'Свернуть' : 'Развернуть',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ),
      ],
    );
  }
}
