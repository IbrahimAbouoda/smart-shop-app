import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StoreProvider extends ChangeNotifier{
  void addToStore(BuildContext context, String name,  String note) async {

      final CollectionReference cartCollection = FirebaseFirestore.instance.collection('Stores');

      // Check if the data already exists in Firestore
      final QuerySnapshot existingData = await cartCollection
          .where('name', isEqualTo: name)



          .get();

      if (existingData.docs.isNotEmpty) {
        // Data already exists, show a SnackBar
      } else {
        // Data doesn't exist, add the product data to Firestore
        final Map<String, dynamic> productData = {
          'name': name,

          'note': note,

        };

        cartCollection.add(productData).then((value) {
          // Product added successfully
          // You can also show a confirmation message to the user if needed.
          // You may want to handle errors and edge cases as well.
        }).catchError((error) {
          // Handle errors if the product couldn't be added to the cart.
          // You can display an error message to the user.
          print("Error adding product to cart: $error");
        });
      }
      notifyListeners();



  }

}