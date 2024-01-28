import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repositories/event/event.dart';
import 'package:good_trip/core/presentation/bloc/weather_state.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';

import '../../../core/data/models/models.dart';
import '../../../core/presentation/bloc/weather_event.dart';
import '../../../core/presentation/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Tour>? eventList;
  List<Tour>? audioGuideList;

  @override
  void initState() {
    _loadEventList();
    _loadEventLikedList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => WeatherBloc()..add(const WeatherCurrentPositionRequested()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadSuccess) {
                  return Geolocation(weather: state.weather,);
                }
                return const Center(child: CircularProgressIndicator(),);
              }
              ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded, size: 24, color: Colors.black,),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate((query) =>
                        BlocProvider.of<WeatherBloc>(context)
                            ..add(WeatherRequested(city: query))));
                },
            ),
          ],
        ),
        body: (eventList == null)
            ? const Center(child: CircularProgressIndicator(),)
            : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TourScrollList(tourList: eventList!,
                        title: 'Популярные места'),
                    TourScrollList(tourList: eventList!,
                      title: 'Аудиоэкскурсия', icon: Icons.headphones_rounded,),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Future<void> _loadEventList() async{
    eventList = await EventRepository().getTripEventList();
    setState(() {});
  }

  Future<void> _loadEventLikedList() async{}

  void search() {}
}
