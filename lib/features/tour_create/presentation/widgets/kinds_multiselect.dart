import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../core/theme/theme.dart';

class KindsMultiSelect extends StatefulWidget {
  const KindsMultiSelect({super.key, required this.func});

  final Function func;

  @override
  State<KindsMultiSelect> createState() => _KindsMultiSelectState();
}

class _KindsMultiSelectState extends State<KindsMultiSelect> {
  List<String> selected = [];

  List<String> get dropdownItems {
    List<String> menuItems = [];
    for (final TourType value in TourType.values) {
      menuItems.add(value.displayText);
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect(
      decoration: getDecoration("Категория"),
      selectedValuesStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: colors.darkGray, overflow: TextOverflow.ellipsis),
      onChanged: (List<String> x) {
        setState(() {
          selected = x;
        });
        widget.func(selected);
      },
      options: dropdownItems,
      selectedValues: selected,
      hint: Text(
        'Категория',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  InputDecoration getDecoration(String text) {
    return InputDecoration(
      hintText: text,
      hintStyle: Theme.of(context).textTheme.bodySmall,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: colors.lightGray2),
        borderRadius: BorderRadius.circular(16),
      ),
      counterStyle: Theme.of(context).textTheme.bodySmall,
    );
  }
}
