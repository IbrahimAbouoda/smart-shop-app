import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_images.dart';
import 'card_requst_user.dart';

class BodyRequstList extends StatelessWidget {
  const BodyRequstList({Key? key}) : super(key: key);

  Future<List<DocumentSnapshot>> fetchUserData() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Users').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No user data available.');
        } else {
          final userData = snapshot.data!;
          final listView1Data = userData.where((user) {
            final total = user['total'] ?? 0; // Assuming 'total' is a field in Firestore
            return total >= 500;
          }).toList();

          final listView2Data = userData.where((user) {
            final total = user['total'] ?? 0;
            return 300 <= total && total < 500;
          }).toList();

          final listView3Data = userData.where((user) {
            final total = user['total'] ?? 0;
            return 200 <= total && total < 300;
          }).toList();

          final listView4Data = userData.where((user) {
            final total = user['total'] ?? 0;
            return total < 200;
          }).toList();

          return TabBarView(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: listView1Data.length,
                  itemBuilder: (context, index) {
                    final user = listView1Data[index];
                    return CardRequst(
                      image: Assets.general,
                      name: user['name'] ?? 'Unknown',
                      type: 'عام',
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listView2Data.length,
                  itemBuilder: (context, index) {
                    final user = listView2Data[index];
                    return CardRequst(
                      image: Assets.silver,
                      name: user['name'] ?? 'Unknown',
                      type: 'فضي',
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listView3Data.length,
                  itemBuilder: (context, index) {
                    final user = listView3Data[index];
                    return CardRequst(
                      image: Assets.gold,
                      name: user['name'] ?? 'Unknown',
                      type: 'ذهبي',
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listView4Data.length,
                  itemBuilder: (context, index) {
                    final user = listView4Data[index];
                    return CardRequst(
                      image: Assets.medal,
                      name: user['name'] ?? 'Unknown',
                      type: 'الماسي',
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
