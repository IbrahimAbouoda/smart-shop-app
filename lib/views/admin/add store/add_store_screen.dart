import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaza_shop/providers/store_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AddStore extends StatefulWidget {
  const AddStore({Key? key}) : super(key: key);

  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  TextEditingController? nameController;
  TextEditingController? decController;
  XFile? _selectedImage;
  FirebaseAuth _auth = FirebaseAuth.instance; // Create an instance of FirebaseAuth

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    decController = TextEditingController();
  }

  @override
  void dispose() {
    nameController?.dispose();
    decController?.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage;
    });
  }

  Future<void> addStore(String name, String description) async {
    try {
      final storage = firebase_storage.FirebaseStorage.instance;
      final storeRef = storage.ref().child('store_images/${DateTime.now().toString()}');

      if (_selectedImage != null) {
        await storeRef.putFile(File(_selectedImage!.path));

        final imageUrl = await storeRef.getDownloadURL();

        final user = _auth.currentUser; // Get the current user using _auth.currentUser
        if (user != null) {
          final userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();

          if (userDoc.exists) {
            final userRole = userDoc.get('role');
            if (userRole == 'admin') {
              // Only admins can add stores
              await FirebaseFirestore.instance.collection('Store').add({
                'name': name,
                'description': description,
                'imageUrl': imageUrl,
              });
            } else {
              print('You do not have permission to add stores.');
            }
          } else {
            print('User document does not exist.');
          }
        } else {
          print('No user is currently signed in.');
        }

        Navigator.pushNamed(context, "/homeAdmin");
      }
    } catch (e) {
      print('Error posting store: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    var storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Store"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20, right: 10, left: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "مرحبا فيك في متجر غزة للملابس",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "أنشأ متجرك الان",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 7,
              ),
              ElevatedButton(
                onPressed: pickImage,
                child: Text("أضف صورة"),
              ),
              _selectedImage != null
                  ? Image.file(File(_selectedImage!.path))
                  : Container(),
              SizedBox(
                height: 15,
              ),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Store Name",
                  border: OutlineInputBorder(),
                ),
                controller: nameController,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                controller: decController,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController?.text ?? "";
                  String notes = decController?.text ?? "";
                  storeProvider.addToStore(context, name, decController!.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم انشاء متجرك"),));
                 Navigator.pushNamed(context, "/AddProduct1");
                  },
                child: Text("Create Store"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
