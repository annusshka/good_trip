import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/theme.dart';

class ProfileSettingsList extends StatelessWidget {
  final String title;
  final List<String> elementList;
  const ProfileSettingsList({super.key,
    required this.title, required this.elementList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge, ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(elementList[i],
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                size: 24,
                color: colors.gray,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 1,
            thickness: 1,
            color: colors.lightGray1,
          ),
          itemCount: elementList.length,
        )
      ],
    );
  }
}
