import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  double total = 0.0;

  // Method to update the total
  void updateTotal(double newTotal) {

    total = newTotal;
    notifyListeners(); // Notify listeners to rebuild widgets
  }



Future<void> updateTotalInFirestore() async {
  try {
    final userDoc = FirebaseFirestore.instance.collection('Users').doc(
        'YOUR_USER_ID'); // Replace 'YOUR_USER_ID' with the actual user ID
    await userDoc.update({'total': total});
  } catch (error) {
    print('Error updating total in Firestore: $error');
  }

  }}