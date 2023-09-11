import 'package:flutter/material.dart';

import '../../../../../models/category_model.dart';

class CategoryNameSearchDelegate extends SearchDelegate<CategoryModel> {
  final List<CategoryModel> categories; // Replace with your list of categories

  CategoryNameSearchDelegate(this.categories);

  @override
  String get searchFieldLabel => 'ابحث عن اسم الصنف';

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
        close(context, categories.first);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = categories.where((category) => category.name.contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final category = results[index];
        return ListTile(
          title: Text(category.name),
          onTap: () {
            close(context, category);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = categories
        .where((category) => category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final category = suggestionList[index];
        return ListTile(
          title: Text(category.name),
          onTap: () {
            query = category.name;
            showResults(context);
          },
        );
      },
    );
  }
}
