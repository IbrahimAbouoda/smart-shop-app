import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaza_shop/core/utils/app_images.dart';
import '../core/utils/constant.dart';

class DrewerUser extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DrewerUser({super.key});

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDataByEmail(
      String email) {
    return FirebaseFirestore.instance.collection('Users').doc(email).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: fetchUserDataByEmail("${_auth.currentUser!.email}"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // or any loading widget
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('User data does not exist.');
        } else {
          final userData = snapshot.data!.data();

          final userName = userData?['name'] as String?;

          return Scaffold(
              body: SizedBox(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: ConstantStayles.kPrimColor,
                  ),
                  accountName: Image.asset(Assets.imagesLogo),
                  accountEmail: Text(userName ?? "Email not available"),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('الرئيسية'),
                  onTap: () {
                    Navigator.pushNamed(context, "/homeUser");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.card_travel),
                  title: const Text('سلة المشتريات'),
                  onTap: () {
                    Navigator.pushNamed(context, "/carPay");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.groups_2_sharp),
                  title: const Text('التجار'),
                  onTap: () {
                    Navigator.pushNamed(context, "/showAdmin");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.topic_sharp),
                  title: const Text('الاحصائيات'),
                  onTap: () {
                    Navigator.pushNamed(context, "/details_product");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.not_listed_location_rounded),
                  title: const Text('من نحن ؟'),
                  onTap: () {
                    Navigator.pushNamed(context, "/whome");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('الاعدادات'),
                  onTap: () {
                    Navigator.pushNamed(context, "/settings");
                  },
                ),
                // ... Other ListTiles ...
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('تسجيل خروج'),
                  onTap: () {
                    Navigator.pushNamed(context, "/login_signUp");
                  },
                ),
                // ... Other ListTiles ...
              ],
            ),
          ));
        }
      },
    );
  }
}
