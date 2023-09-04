import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_images.dart';
import '../core/utils/constant.dart';
import '../views/admin/profile/widgets/listTil.dart';

class DrwerAdmin extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DrwerAdmin({super.key});

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // or any loading widget
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final User? user = snapshot.data;

            return Drawer(
                child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: ConstantStayles.kPrimColor,
                  ),
                  accountName: const CircleAvatar(
                    backgroundImage: AssetImage(Assets.logo),
                  ),
                  accountEmail: Text(user?.email ?? "Email not available"),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('الرئيسية'),
                  onTap: () {
                    // Update the UI to refresh
                    Navigator.pushNamed(context, "/homeAdmin");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_search_rounded),
                  title: const Text('الزبون'),
                  onTap: () {
                    // Update the UI to refresh
                    Navigator.pushNamed(context, "/showAdmins");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.man_4_outlined),
                  title: const Text('صفحتي'),
                  onTap: () {
                    Navigator.pushNamed(context, "/myProfile");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.redo_sharp),
                  title: const Text('طلبات المستخدمين'),
                  onTap: () {
                    Navigator.pushNamed(context, "/requstUser");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_search_outlined),
                  title: const Text('المشتريين'),
                  onTap: () {
                    Navigator.pushNamed(context, "/showUser");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('اضافة متجر '),
                  onTap: () {
                    Navigator.pushNamed(context, "/AddStore");
                    // Perform navigation to Help screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_shopping_cart_outlined),
                  title: const Text(' اضافة منتج'),
                  onTap: () {
                    // Perform logout functionality
                    Navigator.pushNamed(context, "/AddProduct");
                  },
                ),
                ListTileProfiles(
                    onTap: () {},
                    iconData: Icons.info_outlined,
                    titel: "حول التطبيق"),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Perform logout functionality
                    Navigator.pushNamed(context, "/login_signUp");
                  },
                ),
              ],
            ));
          }
        });
  }
}
