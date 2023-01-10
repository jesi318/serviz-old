import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? reg_no;
  String? classname;
  String? role;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.reg_no,
      this.classname,
      this.role});

  // data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        reg_no: map['reg_no'],
        classname: map['classname'],
        role: map['role']);
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'reg_no': reg_no,
      'classname': classname,
      'role': role
    };
  }
}
