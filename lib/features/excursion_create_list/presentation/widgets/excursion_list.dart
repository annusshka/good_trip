import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/empty_created_list.dart';

class ExcursionList extends StatelessWidget {
  const ExcursionList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<ExcursionCreateListBloc, ExcursionCreateListState>(
      builder: (context, state) {
        if (state is ExcursionCreateListLoadedSuccess) {
          if (state.excursionList.isEmpty) {
            return const EmptyCreatedList(emptyText: 'Вы пока не создали ни одной аудиоэкскурсии');
          }
          return ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: 15.0,
            ),
            itemCount: state.excursionList.length,
            separatorBuilder: (BuildContext context, _) => SizedBox(
              height: height * 0.03,
            ),
            itemBuilder: (context, i) {
              return ExcursionCreateListElement(
                excursion: state.excursionList[i],
                iconSize: height * 0.3 * 0.3,
              );
            },
          );
        }
        if (state is ExcursionCreateListLoadInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const EmptyCreatedList(emptyText: 'Вы пока не создали ни одной аудиоэкскурсии');
      },
    );
  }
}
