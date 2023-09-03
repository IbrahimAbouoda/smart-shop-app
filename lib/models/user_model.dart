
class UsersModel {
  final int id;
  final String name;
  final String email;
  final String typeAccount;
  final int superAdmin;
  final String status;
  final dynamic storeId;
  final dynamic phone;
  final dynamic providerId;
  final dynamic emailVerifiedAt;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.typeAccount,
    required this.superAdmin,
    required this.status,
    required this.storeId,
    required this.phone,
    required this.providerId,
    required this.emailVerifiedAt,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      typeAccount: json['type_account'],
      superAdmin: json['super_admin'],
      status: json['status'],
      storeId: json['store_id'],
      phone: json['phone'],
      providerId: json['provider_id'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }
}
