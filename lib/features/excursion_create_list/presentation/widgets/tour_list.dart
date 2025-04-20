import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/empty_created_list.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/tour_create_list_element.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create/tour_create.dart';

class TourList extends StatelessWidget {
  const TourList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocListener<TourCreateBloc, TourCreateState>(
      listener: (BuildContext context, TourCreateState state) {
        if (state is TourCreatedSuccess || state is TourRemovedSuccess) {
          BlocProvider.of<TourCreateListBloc>(context).add(
            const ToursCreateByActualUserRequested(),
          );
        }
      },
      child: BlocBuilder<TourCreateListBloc, TourCreateListState>(
        builder: (context, state) {
          if (state is TourCreateListLoadedSuccess) {
            if (state.tourList.isEmpty) {
              return const EmptyCreatedList(emptyText: 'Вы пока не создали ни одного аудиотура');
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
          return const EmptyCreatedList(emptyText: 'Вы пока не создали ни одного аудиотура');
        },
      ),
    );
  }
}
