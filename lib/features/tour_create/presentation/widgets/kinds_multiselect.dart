import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/enum/tour_type.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/kind/kind_cubit.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';

class KindsMultiSelect extends StatefulWidget {
  const KindsMultiSelect({super.key});

  @override
  State<KindsMultiSelect> createState() => _KindsMultiSelectState();
}

class _KindsMultiSelectState extends State<KindsMultiSelect> {
  List<String> get dropdownItems {
    List<String> menuItems = [];
    for (final TourType value in TourType.values) {
      menuItems.add(value.displayText);
    }
    return menuItems;
  }

  final KindCubit cubit = KindCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindCubit, KindState>(
        bloc: cubit,
        builder: (kindContext, state) {
      return Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrayEA,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Text(
              'Категория',
              style: AppTextTheme.normal16,
            ),
            items: dropdownItems.map((item) {
              List<String> kinds = state.kindList;
              bool isSelected = kinds.contains(item);

              return DropdownMenuItem(
                value: item,
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    return InkWell(
                      onTap: () {
                        menuSetState(() {
                          cubit.selectKinds(item);
                          isSelected = !isSelected;
                        });
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item,
                                style: AppTextTheme.normal16.copyWith(
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            value: state.kindList.isEmpty ? null : state.kindList.last,
            onChanged: (_) {},
            selectedItemBuilder: (context) {
              return dropdownItems.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      state.kindList.join(', '),
                      style: AppTextTheme.normal16.copyWith(
                        color: AppColors.darkGray,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(left: 12, right: 8),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );
    });
  }
}
