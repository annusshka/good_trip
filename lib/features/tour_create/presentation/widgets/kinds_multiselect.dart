import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:multiselect/multiselect.dart';

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
      decoration: getDecoration('Категория'),
      selectedValuesStyle: AppTextTheme.semiBold18.copyWith(
        color: AppColors.darkGray,
        overflow: TextOverflow.ellipsis,
      ),
      onChanged: (List<String> x) {
        setState(() {
          selected = x;
        });
        widget.func(selected);
      },
      options: dropdownItems,
      selectedValues: selected,
      hint: const Text(
        'Категория',
        style: AppTextTheme.normal16,
      ),
    );
  }

  InputDecoration getDecoration(String text) {
    return InputDecoration(
      hintText: text,
      hintStyle: AppTextTheme.normal16,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: AppColors.lightGrayEA),
        borderRadius: BorderRadius.circular(16),
      ),
      counterStyle: AppTextTheme.normal16,
    );
  }
}
