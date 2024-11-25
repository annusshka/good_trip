import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/enum/tour_type.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

class KindsMultiSelect extends StatefulWidget {
  const KindsMultiSelect({super.key, required this.onKindsSelected});

  final Function(List<String>) onKindsSelected;

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
                hint: Text(
                  'Категория',
                  style: AppTextTheme.semiBold18.copyWith(
                    color: AppColors.lightGray,
                  ),
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
                            widget.onKindsSelected(state.kindList);
                          },
                          child: Container(
                            height: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                if (isSelected)
                                  const Icon(
                                    Icons.check_box_outlined,
                                    color: AppColors.gray,
                                  )
                                else
                                  const Icon(
                                    Icons.check_box_outline_blank,
                                    color: AppColors.gray,
                                  ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextTheme.semiBold18.copyWith(
                                      color: AppColors.gray,
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
                          style: AppTextTheme.semiBold18.copyWith(
                            color: AppColors.gray,
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
