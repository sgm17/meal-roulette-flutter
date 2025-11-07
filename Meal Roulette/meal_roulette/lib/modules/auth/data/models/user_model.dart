/// Simple immutable user profile entity stored in Firestore.
/// Keeps things small and serializable for easy mapping/testing.
class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String? avatarUrl;

  const UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'updatedAt': DateTime.now().toUtc(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }
}
