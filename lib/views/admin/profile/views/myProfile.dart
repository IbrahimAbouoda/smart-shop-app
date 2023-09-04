import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../components/general_widgets.dart';
import '../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../core/utils/app_images.dart';

class Profile extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Profile({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDataByEmail(
      String email) {
    return FirebaseFirestore.instance.collection('Users').doc(email).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {},
                child: Image.asset(
                  Assets.logo,
                  width: 30,
                  height: 30,
                ))
          ],
          leading: TextButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.logo),
            const SizedBox(height: 20),
            Expanded(
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: fetchUserDataByEmail("${_auth.currentUser!.email}"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text('User data does not exist.');
                      } else {
                        final userData = snapshot.data!.data();
                        final userRole = userData?['role'] as String?;
                        final userName = userData?['name'] as String?;
                        final userEmail =
                            _auth.currentUser?.email ?? "Email not available";

                        String role = userRole.toString();
                        if (role == "user") {
                          role = "صاحب محل";
                        } else {
                          role = "تاجر";
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "الاسم",
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 25),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      width: double.infinity,
                                      alignment: Alignment.bottomLeft,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        userName ?? "Name not available",
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "الايميل",
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 25),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      width: double.infinity,
                                      alignment: Alignment.bottomLeft,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        userEmail,
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "نوع الحساب",
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 25),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      width: double.infinity,
                                      alignment: Alignment.bottomLeft,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        userRole ?? "Name not available",
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        );
                      }
                    })),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonAppBar1(
                    onTapHome: () => Navigator.pushNamed(context, "/homeAdmin"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
