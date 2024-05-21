import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: colors.lightGray,
      child: Text(
        "Здесь пока пусто",
        style:
        Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
