import 'package:flutter/material.dart';
import '../../../components/widgets/general_widgets/card_show_user.dart';
import '../../../models/user_model.dart';
import '../../../service/backend/users_servic.dart';

class ShowUsers extends StatefulWidget {

  ShowUsers({super.key});

  @override
  State<ShowUsers> createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  final UserService userService = UserService();
  final productService = UserService();
  late Future<List<UsersModel>> products;
  final TextEditingController searchController = TextEditingController();

  List<UsersModel> userList = [];

  @override
  void initState() {
    super.initState();
    // Fetch products when the widget is initialized
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedProducts = await productService.getUsers("salesman");
    setState(() {
      userList = fetchedProducts;
    });
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all products
      fetchUsers();
    } else {
      // Filter the products based on the query
      final filteredList = userList
          .where((product) => product.name.contains(query))
          .toList();

      setState(() {
        userList = filteredList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, "/homeAdmin")),
        title: const Text("المشتريين"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 5),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                onChanged: (value) {
                  // Trigger search when the text changes
                  performSearch(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: FutureBuilder<List<UsersModel>>(
                future: userService.getUsers("salesman"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No users available.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        return CardShowUserSels(
                          name: user.name,
                          onPresseddelte: () => snapshot.data!.remove(index),
                          onPressedAdd: () =>
                              Navigator.pushNamed(context, "/chats"),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SearchResultPage extends StatelessWidget {
  final String query;

  const SearchResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Implement your search logic here using the 'query' parameter
    // to filter and display the search results.

    // For example, you can create a FutureBuilder to display search results.
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for: $query'),
      ),
      body: FutureBuilder<List<UsersModel>>(
        // Replace 'YourProductModel' with your actual product model class.
        // Implement your search logic here, returning a list of search results.
        // For demonstration purposes, I'm using an empty list.
        future: searchUsers(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found.'));
          } else {
            // Display your search results using a ListView.builder or any other widget.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                // Build and return your product item widget.
                return ListTile(
                  title: Text(user.name),

                  // Add any other relevant information or actions for each product.
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<UsersModel>> searchUsers(String query) async {
    // Implement your search logic here to filter and return search results.
    // For demonstration purposes, I'm using an empty list.
    return [];
  }
}
