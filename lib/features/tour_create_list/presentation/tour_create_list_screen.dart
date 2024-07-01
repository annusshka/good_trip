import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';

import '../../../core/presentation/bloc/tour_create_list/tour_create_list.dart';
import '../../../core/presentation/widgets/widgets.dart';
import '../../../core/theme/theme.dart';
import '../../tour_create/presentation/bloc/tour_create.dart';

@RoutePage()
class TourCreateListScreen extends StatelessWidget {
  const TourCreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocListener<TourCreateBloc, TourCreateState>(
      listener: (BuildContext context, TourCreateState state) {
        if (state is TourCreatedSuccess || state is TourRemovedSuccess) {
          BlocProvider.of<TourCreateListBloc>(context).add(const TourListCreateByActualUserRequested());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            'Мои экскурсии',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocBuilder<TourCreateListBloc, TourCreateListState>(
            builder: (context, state) {
          if (state is TourCreateListLoadedSuccess) {
            if (state.tourList.isEmpty) {
              return const EmptyList();
              /*return Center(
                child: Text(
                  "Здесь пока пусто",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );*/
            }
            return ListView.separated(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors.pink_,
          onPressed: () {
            AutoRouter.of(context).push(const TourCreateRoute());
          },
          child: Icon(
            Icons.add,
            color: colors.white,
          ),
        ),
      ),
    );
  }
}
