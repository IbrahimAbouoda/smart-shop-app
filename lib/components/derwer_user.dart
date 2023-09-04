import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/utils/constant.dart';

class DrewerUser extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: getCurrentUser(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // or any loading widget
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
                accountName: Text(user?.displayName ?? "Name not available"),
                accountEmail: Text(user?.email ?? "Email not available"),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('الرئيسية'),
                onTap: () {
                  Navigator.pushNamed(context, "/homeUser");
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
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
                leading: const Icon(Icons.settings),
                title: const Text('الاعدادات'),
                onTap: () {
                  Navigator.pushNamed(context, "/homeUser");
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
            ],
          ),

        );
      }
    });

        }
  }
