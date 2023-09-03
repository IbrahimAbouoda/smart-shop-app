import 'package:flutter/material.dart';
import '../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../components/widgets/general_widgets/card_show_user.dart';
import '../../../models/user_model.dart';
import '../../../service/backend/users_servic.dart';

class ShowAdmins extends StatelessWidget {
  final UserService userService = UserService();

  ShowAdmins({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 5),
        child: Column(
          children: [
            const TopBarApp1(
              titel: 'التجار',
            ),
            Expanded(
              flex: 1,
              child: TextFormField(
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
                future: userService.getUsers("trader"),
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
                          onPresseddelte: () => userService.deleteUser(index),
                          onPressedAdd: () =>
                              Navigator.pushNamed(context, "/favori"),
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
