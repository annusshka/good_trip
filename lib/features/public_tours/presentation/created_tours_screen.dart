import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';

@RoutePage()
class CreatedToursScreen extends StatelessWidget {
  const CreatedToursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocListener<TourCreateBloc, TourCreateState>(
        listener: (BuildContext context, TourCreateState state) {
          if (state is TourRemovedSuccess) {
            BlocProvider.of<TourCreateListBloc>(context)
                .add(const TourCreateListRequested());
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Экскурсии пользователей',
              style: AppTextTheme.semiBold26,
            ),
          ),
          body: BlocBuilder<TourCreateListBloc, TourCreateListState>(
              builder: (context, state) {
            if (state is TourCreateListLoadedSuccess) {
              if (state.tourList.isEmpty) {
                return const EmptyList();
              }
              return ListView.separated(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                itemCount: state.tourList.length,
                separatorBuilder: (BuildContext context, _) => SizedBox(
                  height: height * 0.03,
                ),
                itemBuilder: (context, i) {
                  return TourCreateListElement(
                      tour: state.tourList[i], iconSize: height * 0.3 * 0.3);
                },
              );
            }
            if (state is TourCreateListLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          }),
        ));
  }
}
