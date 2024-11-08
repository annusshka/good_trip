import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

@RoutePage()
class CreatedExcursionsScreen extends StatelessWidget {
  const CreatedExcursionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocListener<ExcursionCreateBloc, ExcursionCreateState>(
      listener: (BuildContext context, ExcursionCreateState state) {
        if (state is ExcursionRemovedSuccess) {
          BlocProvider.of<ExcursionCreateListBloc>(context)
              .add(const ExcursionCreateListRequested());
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
        body: BlocBuilder<ExcursionCreateListBloc, ExcursionCreateListState>(
            builder: (context, state) {
          if (state is ExcursionCreateListLoadedSuccess) {
            if (state.excursionList.isEmpty) {
              return const EmptyList();
            }
            return ListView.separated(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              itemCount: state.excursionList.length,
              separatorBuilder: (BuildContext context, _) => SizedBox(
                height: height * 0.03,
              ),
              itemBuilder: (context, i) {
                return ExcursionCreateListElement(
                    tour: state.excursionList[i], iconSize: height * 0.3 * 0.3);
              },
            );
          }
          if (state is ExcursionCreateListLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
