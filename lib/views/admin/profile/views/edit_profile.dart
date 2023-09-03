import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
  File? _selectedImage; // Store the selected image file

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
        actions: const [],
        leading: TextButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, "/profile")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Show image picker when the user taps the image
                selectImage();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : null, // Remove the default image
              ),
            ),
          ),
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
              TextButton(
                  child:
                      const Text('حفظ'), // Add buttonText for the "Save" button
                  onPressed: () {
                    updateUserData();
                    Navigator.pushNamed(context, "/profile");
                  }),
            ],
          ),
        ],
      ),
    );
  }

  // Function to open image picker
  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
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

      if (_selectedImage != null) {
        final imageFileName = 'user_${widget._auth.currentUser!.uid}.jpg';
        final imageRef = FirebaseStorage.instance.ref().child(imageFileName);

        final uploadTask = imageRef.putFile(_selectedImage!);

        await uploadTask.whenComplete(() async {
          final imageUrl = await imageRef.getDownloadURL();

          // Update the 'image' field in Firestore with the imageUrl
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(widget._auth.currentUser!.email)
              .update({'image': imageUrl});
        });
      }

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
