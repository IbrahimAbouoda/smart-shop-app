import 'package:flutter/material.dart';

import '../../../../../models/stores_model.dart'; // Import your store model

class StoreNameSearchDelegate extends SearchDelegate<StoreModel> {
  final List<StoreModel> stores; // Replace with your list of stores

  StoreNameSearchDelegate(this.stores);

  @override
  String get searchFieldLabel => 'Search Store Name';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context,stores.first);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = stores.where((store) => store.name.contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final store = results[index];
        return ListTile(
          title: Text(store.name),
          onTap: () {
            close(context, store);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = stores
        .where((store) => store.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final store = suggestionList[index];
        return ListTile(
          title: Text(store.name),
          onTap: () {
            query = store.name;
            showResults(context);
          },
        );
      },
    );
  }
}
