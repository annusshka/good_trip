import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/tour_create_list_element.dart';

class TourList extends StatelessWidget {
  const TourList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<TourCreateListBloc, TourCreateListState>(
      builder: (context, state) {
        if (state is TourCreateListLoadedSuccess) {
          if (state.tourList.isEmpty) {
            return const EmptyList();
          }
          return ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: 15.0,
            ),
            itemCount: state.tourList.length,
            separatorBuilder: (BuildContext context, _) => SizedBox(
              height: height * 0.03,
            ),
            itemBuilder: (context, i) {
              return TourCreateListElement(
                tour: state.tourList[i],
                iconSize: height * 0.3 * 0.3,
              );
            },
          );
        }
        if (state is TourCreateListLoadInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
