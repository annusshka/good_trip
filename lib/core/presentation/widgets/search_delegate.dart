import 'package:flutter/material.dart';
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
          Navigator.of(context).pop();
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
        //Navigator.pop(context);
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
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResults = ["Helsinki", "Moscow", "Berlin", "New York", "Saint Petersburg", query]
        .where((element) => element.contains(query))
        .toList();

    return ListView.separated(
      itemCount: searchResults.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        thickness: 1,
        indent: 60,
        color: Color.fromARGB(100, 241, 241, 245),
      ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(
            Icons.search_rounded,
            size: 24,
            color: Color.fromARGB(100, 181, 181, 190),
          ),
          title: Text(searchResults[index]),
          onTap: () {
            selectedResult = searchResults[index];
            callback(selectedResult);
            //Navigator.pop(context);
          },
        );
      },
    );
  }
}