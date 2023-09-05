import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { admin, user }

class UserModel {
  String? imageUrl;
  String name;
  String email;
  String role;
  String? token;
 double? total;

  UserModel({
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
     this.total,
  });

  factory UserModel.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final role = data?['role'];
    double? total = role == 'user' && data != null ? data['total'] as double : null;
    return UserModel(
      imageUrl: data?['imageUrl'],
      name: data?['name'],
      email: data?['email'],
      role: role,
      token: data?['token'],
      total: total,
    );
  }
  // Factory constructor to create a UserModel instance from a map (JSON).
  factory UserModel.fromJson(Map<String, dynamic> data) {
    final role = data['role'];
    double? total = role == 'user' ? data['total'] as double : null; // Set total to null if the role is not 'user'
    return UserModel(
      imageUrl: data['imageUrl'],
      name: data['name'],
      email: data['email'],
      role: role,
      token: data['token'],
      total: total,
    );
  }






Map<String, dynamic> toFirebase() {
    return {
      "imageUrl": imageUrl,
      "name": name,
      "email": email,
      "role": role,
      "token": token,
      "total": total,
    };
  }
}
