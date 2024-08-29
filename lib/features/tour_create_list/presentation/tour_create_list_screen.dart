import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';

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
          BlocProvider.of<TourCreateListBloc>(context).add(
            const TourListCreateByActualUserRequested(),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: const Text(
            'Мои экскурсии',
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
          backgroundColor: AppColors.pink,
          onPressed: () {
            AutoRouter.of(context).push(const TourCreateRoute());
          },
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
