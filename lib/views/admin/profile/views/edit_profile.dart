import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../components/general_widgets.dart';
import '../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../core/utils/app_images.dart';

class EditProfile extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  EditProfile({Key? key}) : super(key: key);

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDataByEmail(
      String email) {
    return FirebaseFirestore.instance.collection('Users').doc(email).get();
  }

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing user data
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final snapshot =
        await widget.fetchUserDataByEmail("${widget._auth.currentUser!.email}");
    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      nameController.text = userData['name'] ?? '';
      emailController.text = userData['email'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              updateUserData();
            },
            icon: const Icon(
              Icons.edit_square,
              size: 40,
            ),
          )
        ],
        leading: TextButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.imagesLogo),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UserDataTextField(
                    labelText: 'الاسم',
                    controller: nameController,
                  ),
                  UserDataTextField(
                    labelText: 'الايميل',
                    controller: emailController,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonAppBar1(
                onTapHome: () => Navigator.pushNamed(context, "/homeAdmin"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updateUserData() async {
    final newName = nameController.text;
    final newEmail = emailController.text;
    final updatedData = {
      'name': newName,
      'email': newEmail,
    };

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget._auth.currentUser!.email)
          .update(updatedData);
      print('User data updated successfully.');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}

class UserDataTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const UserDataTextField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            child: Text(
              labelText,
              style: GoogleFonts.aBeeZee(fontSize: 25),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: labelText,
                hintStyle: const TextStyle(fontSize: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
