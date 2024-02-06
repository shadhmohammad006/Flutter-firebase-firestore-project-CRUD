import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, username, email;
  UserModel({this.id, this.username, this.email});
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
        id: map.id, username: map['username'], email: map["email"]);
  }
  Map<String, dynamic> toMap() {
    return {"email": email, "username": username};
  }
}
