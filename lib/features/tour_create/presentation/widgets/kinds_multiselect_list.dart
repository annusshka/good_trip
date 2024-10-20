// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:good_trip/core/data/models/enum/enum.dart';
// import 'package:good_trip/core/theme/app_colors.dart';
// import 'package:good_trip/core/theme/app_text_theme.dart';
// import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';
//
// class KindsMultiselectList extends StatelessWidget {
//   const KindsMultiselectList({super.key});
//
//   List<String> get dropdownItems {
//     List<String> menuItems = [];
//     for (final TourType value in TourType.values) {
//       menuItems.add(value.displayText);
//     }
//     return menuItems;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<KindBloc, KindState>(
//       builder: (context, state) {
//         return Container(
//           height: MediaQuery.of(context).size.height / 2,
//           alignment: Alignment.center,
//           child: ListView.separated(
//             separatorBuilder: (BuildContext context, int index) {
//               return const Divider(
//                 thickness: 1,
//                 color: AppColors.lightGray,
//               );
//             },
//             itemCount: dropdownItems.length,
//             itemBuilder: (_, index) {
//               return Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Checkbox(
//                       value: state.selectedKinds.contains(dropdownItems[index]),
//                       onChanged: (_) {
//                         BlocProvider.of<KindBloc>(context).add(
//                           UpdateKindsRequested(
//                             kind: dropdownItems[index],
//                             kinds: state.selectedKinds,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       dropdownItems[index],
//                       style: AppTextTheme.normal16,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
