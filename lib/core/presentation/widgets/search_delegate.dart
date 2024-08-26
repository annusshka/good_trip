import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';

class MySearchDelegate extends SearchDelegate {
  late String selectedResult;
  final Function callback;

  MySearchDelegate(this.callback);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close, size: 24, color: Colors.black,),
        onPressed: () {
          AutoRouter.of(context).pop();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search_rounded, size: 24, color: Colors.black,),
      onPressed: () {
        selectedResult = query;
        callback(query);
        close(context, query);
        //AutoRouter.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const HomeScreen();
  }

  @override
  void showResults(BuildContext context) {
    selectedResult = query;
    callback(query);
    close(context, query);
    //AutoRouter.of(context).pop();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResults = ["Хельсинки", "Москва", "Берлин", "Нью-Йорк", "Санкт-Петербург", query]
        .where((element) => element.contains(query))
        .toList();

    return ListView.separated(
      itemCount: searchResults.length,
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1,
        thickness: 1,
        indent: 60,
        color: colors.lightGray1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.search_rounded,
            size: 24,
            color: colors.lightGray,
          ),
          title: Text(searchResults[index]),
          onTap: () {
            selectedResult = searchResults[index];
            callback(selectedResult);
            close(context, query);
            //AutoRouter.of(context).pop();
          },
        );
      },
    );
  }
}