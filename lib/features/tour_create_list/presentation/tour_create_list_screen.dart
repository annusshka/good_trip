import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/features/tour_create_list/presentation/widgets/tour_create_element.dart';

import '../../../core/theme/theme.dart';
import '../../favorite/presentation/bloc/tour_bloc.dart';
import '../../favorite/presentation/bloc/tour_event.dart';
import '../../favorite/presentation/bloc/tour_state.dart';

@RoutePage()
class TourCreateListScreen extends StatelessWidget {
  const TourCreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => TourBloc()
        ..add(const TourRequested(lon: '38.364285', lat: '59.855685')),
      child: BlocBuilder<TourBloc, TourState>(
        builder: (context, state) {
          if (state is TourListLoadedSuccess) {
            return Stack(children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Мои экскурсии',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                body: ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  itemCount: state.tourList.length,
                  separatorBuilder: (BuildContext context, _) => SizedBox(
                    height: height * 0.03,
                  ),
                  itemBuilder: (context, i) {
                    return TourCreateElement(
                        tour: state.tourList[i], iconSize: height * 0.3 * 0.3);
                  },
                ),
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
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
